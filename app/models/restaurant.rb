class Restaurant < ApplicationRecord
  has_many :tables

  validates :name, presence: true
  validates :capacity, presence: true
end
