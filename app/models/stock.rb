class Stock < ApplicationRecord
    has_many :stock_prices, dependent: :destroy
    validates :Name, presence: true, uniqueness: { case_sensitive: false }, 
              length: { minimum: 3, maximum: 25 }
end
