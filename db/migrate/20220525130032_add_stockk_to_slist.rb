class AddstockToSlist < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_prices, :stock_id, :int
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
