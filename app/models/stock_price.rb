class StockPrice < ApplicationRecord
    belongs_to :stock
    validates :price, presence: true
    validates :date, presence: true
end
