class AddPrivacy < ActiveRecord::Migration[6.0]
  def change
    add_column :my_stocks, :privacy, :int,default:1
  
  end
end
