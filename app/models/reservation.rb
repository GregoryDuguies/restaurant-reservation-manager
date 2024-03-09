class Reservation < ApplicationRecord
  belongs_to :restaurant

  has_many :reservation_tables

  validates :owner_name, presence: true
  validates :owner_phone_number, presence: true

  validates :start_datetime, presence: true
  validates :end_datetime, presence: true

  validates :total_guests, presence: true

  # validate start_datetime is in the future, but only on create?

  # NOTE: Not a fan of a callback here
  before_create :set_end_datetime

  # ASSUMPTION: Allocate time at table to 2 hours?
  def set_end_datetime
    self.end_datetime = start_datetime + 2.hours
  end

end
