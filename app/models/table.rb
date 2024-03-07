class Table < ApplicationRecord
  belongs_to :restaurant

  validates :number, presence: true
end
