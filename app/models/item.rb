class Item < ApplicationRecord

    belongs_to :genre
    has_many :order_items
    has_many :carts

    has_one_attached :item_image
    
    
    def price_with_tax
      tax = 1 + 0.10
      ( self.price_without_tax * tax).floor
    end
    
    def get_item_image#(width, height)
      unless item_image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      item_image
      # item_image.variant(resize_to_limit: [width, height]).processed
      # gemのインストールが必要なため相談
    end

end