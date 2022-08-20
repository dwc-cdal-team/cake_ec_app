class Item < ApplicationRecord

    belongs_to :genre
    has_many :order_items
    has_many :carts

    has_one_attached :image

    validates :genre_id, presence: true
    validates :name, presence: true
    validates :introduction, presence: true
    validates :price_without_tax, presence: true
    validates :is_stopped, inclusion: {in: [true, false]}
    validates :image, presence: true

end
