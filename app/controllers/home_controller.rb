class HomeController < ApplicationController

  require 'smarter_csv'

  before_filter :auth_user

  def store
    file = params[:form][:file] rescue nil

    total = 0

    if file

      accepted_formats = %w(.csv .txt)

      valid_extension = accepted_formats.include? File.extname(file.tempfile)


      unless valid_extension

        flash[:message] = 'Invalid file format uploaded (we only accept: ' + accepted_formats.join(', ') + ')'

        return redirect_to(:action => 'index')
      end

      options = {
          :key_mapping => {
            :purchase_count => :qty
          }
      }

      # get the first line and try and guess the separator
      first_line   = File.readlines(file.tempfile).first
      delim_is_tab = first_line.match(/\t/)

      # we would just assume the default separator is a comma
      if delim_is_tab
        options[:col_sep] = "\t"
      end


      SmarterCSV.process(file.tempfile, options) do |row|

        RenewFinancial.create( row.first )
        total += row.first[:item_price]
      end

      flash[:message] = 'File successfully uploaded'
      flash[:notice] = "Revenue contained in the uploaded file #{total}"

    end

    redirect_to(:action => 'index')
  end

end
