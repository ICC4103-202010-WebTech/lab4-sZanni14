
class Customer < ApplicationRecord

  has_many :orders
  has_many :tickets, through: :orders
  validates :email, presence: true, uniqueness: true , format: {with:/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :name , :lastname ,presence: true , allow_blank: false

end


