class Order < ApplicationRecord

    belongs_to :customer
    has_many :order_items

    has_many :items, through: :order_items

    enum order_status: { waiting: 0, paid_up: 1, making: 2, preparing: 3, shipped: 4 }

end
