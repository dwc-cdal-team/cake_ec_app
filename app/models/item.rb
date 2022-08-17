class Item < ApplicationRecord
    
    belongs_to :genre
    has_many :order_items
    has_many :carts
    
    has_one_attached :image
    
end
