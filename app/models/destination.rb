class Destination < ApplicationRecord

    belongs_to :customer

    validates :postal_code, presence: true,
      numericality: { only_integer: true}
    validates :address, presence: true
    validates :name, presence: true

    def address_display
        '〒' + postal_code + ' ' + address + ' ' + name
    end

end