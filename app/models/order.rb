class Order < ApplicationRecord

    belongs_to :customer
    has_many :order_items

    has_many :items, through: :order_items

    enum payment_method: { credit_card: 0, bank_transfer: 1 }
    enum order_status: { waiting: 0, paid_up: 1, making: 2, preparing: 3, shipped: 4 }

end
