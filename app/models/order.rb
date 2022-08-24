class Order < ApplicationRecord

    belongs_to :customer
    has_many :order_items

    has_many :items, through: :order_items

    validates :postal_code, presence: true,
      numericality: { only_integer: true}, length: { is: 7 }
    validates :address, presence: true
    validates :name, presence: true
    validates :postage, presence: true
    validates :total_payment, presence: true
    validates :payment_method, presence: true

    enum payment_method: { credit_card: 0, bank_transfer: 1 }
    enum order_status: { waiting: 0, paid_up: 1, making: 2, preparing: 3, shipped: 4 }

end
