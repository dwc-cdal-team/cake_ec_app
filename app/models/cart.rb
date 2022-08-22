class Cart < ApplicationRecord

    belongs_to :customer
    belongs_to :item

    def subtotal
      item.price_with_tax * amount
    end

end