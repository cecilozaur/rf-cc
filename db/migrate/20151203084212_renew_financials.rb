class RenewFinancials < ActiveRecord::Migration

  def self.up
    create_table :renew_financials do |t|
      t.column :purchaser_name, :string
      t.column :item_description, :string
      t.column :item_price, :float
      t.column :qty, :integer
      t.column :merchant_address, :string
      t.column :merchant_name, :string
    end
  end

end
