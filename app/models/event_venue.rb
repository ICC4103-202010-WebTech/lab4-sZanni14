class EventVenue < ApplicationRecord
  has_many :events
  validates :name , presence: true , allow_blank: false
  validates :address, presence: true, allow_blank: false
  validates :capacity, numericality: {only_integer: true, greater_than_or_equal_to: 10}

end
