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

    # def get_image(width, height)
    #   unless image.attached?
    #     file_path = Rails.root.join('app/assets/images/no_image.jpg')
    #     image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    #   end
    #     image.variant(resize_to_limit: [width, height]).processed
    # end

end
