class MyStockUnique < ActiveRecord::Migration[6.0]
  def change
    add_index :my_stocks, [:stock_id,:user_id], :unique => true
    #Ex:- add_index("admin_users", "username")
  end
end
