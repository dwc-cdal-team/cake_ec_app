class Destination < ApplicationRecord

    belongs_to :customer

    validates :postal_code, presence: true,
      numericality: { only_integer: true}
    validates :address, presence: true
    validates :name, presence: true

end
