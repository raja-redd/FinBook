class Follow < ApplicationRecord
    belongs_to :follower, class_name: "User"

    belongs_to :star, class_name: "User"
   end
  