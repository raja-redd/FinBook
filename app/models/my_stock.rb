class MyStock < ApplicationRecord
   has_many :stocks
   has_many :users
#    
    validates :stock_id, presence: true
    validates :user_id, presence: true
    validates :privacy, presence: true
end
