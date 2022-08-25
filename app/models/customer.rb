class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :carts
  has_many :orders
  has_many :destinations

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true,
    numericality: { only_integer: true}, length: { is: 7 }
  validates :address, presence: true
  validates :telephone_number, presence: true,
    numericality: { only_integer: true}

  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end
