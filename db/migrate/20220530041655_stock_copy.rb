class StockCopy < ActiveRecord::Migration[6.0]
  def change
    add_column :friends, :one_two, :boolean, :defautl=>0
    add_column :friends, :two_one, :boolean, :defautl=>0
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    
    
  end
end
