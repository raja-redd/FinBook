class StockPrice < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_prices do |t|
      t.string :Name
      t.float :price
      t.date :date
      # t.timestamps
    end
  end
end
