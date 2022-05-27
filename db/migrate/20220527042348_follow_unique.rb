class FollowUnique < ActiveRecord::Migration[6.0]
  def change
    add_index :follows, [:follower_id,:star_id], :unique => true
    
  end
end
