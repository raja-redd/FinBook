class Friend < ApplicationRecord
    belongs_to :freind1, class_name: "User"

    belongs_to :freind2, class_name: "User"
end
  