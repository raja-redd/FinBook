class Follow < ActiveRecord::Migration[6.0]
  def change
      create_table :follows do |t|
        t.integer :follower_id
        t.integer :star_id
      end
  end
end
