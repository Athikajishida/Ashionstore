class User < ApplicationRecord

  def blocked?
    blocked
  end
  has_many :addresses, dependent: :destroy
  has_one :cart
  has_many :wishlists
  has_many :orders

  # validates :name, presence: true
  # validates :phone, presence: true, length: { minimum: 10, maximum: 15 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
