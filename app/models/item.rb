class Item < ApplicationRecord

    belongs_to :genre
    has_many :order_items
    has_many :carts

    has_one_attached :item_image


    def price_with_tax
      tax = 1 + 0.10
      ( self.price_without_tax * tax).floor
    end
end