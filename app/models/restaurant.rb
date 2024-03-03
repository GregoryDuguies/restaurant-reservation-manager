class Restaurant < ApplicationRecord
  has_many :tables

  validates :name, presence: true
end
