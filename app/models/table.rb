class Table < ApplicationRecord
  belongs_to :restaurant

  validates :number, presence: true
  validates :capacity, presence: true
end
