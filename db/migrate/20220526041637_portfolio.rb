class Portfolio < ActiveRecord::Migration[6.0]
  def change
    create_table :my_stocks do |t|
      t.integer :user_id
      t.integer :stock_id
      # t.timestamps
    end
  end
end
