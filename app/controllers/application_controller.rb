class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def auth_user

    if session[:user_id]
      @current_user = User.find session[:user_id]

    else
      redirect_to(:action => 'index', :controller => 'auth')

    end
  end
end
