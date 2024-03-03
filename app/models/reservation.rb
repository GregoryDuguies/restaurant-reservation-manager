class Reservation < ApplicationRecord
  # NOTE: Seems like a reservation should belong to both table and restaurant,
  # as opposed to going through a nested association
  belongs_to :table
  belongs_to :restaurant

  validates :owner_name, presence: true
  validates :owner_phone_number, presence: true

  validates :start_datetime, presence: true

  # validate start_datetime is in the future, but only on create?
end
