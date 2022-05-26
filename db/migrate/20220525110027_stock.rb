class Stock < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string :Name
      # t.timestamps
    end
  end
end
  