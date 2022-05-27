class Friend < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
    t.integer :freind1_id
    t.integer :freind2_id
    t.boolean :status1, :default => false
    t.boolean :status2, :default => false
    #Ex:- :default =>''
    end
  end
end
