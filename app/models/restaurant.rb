class Restaurant < ApplicationRecord
  has_many :tables
  has_many :reservations

  validates :name, presence: true

  def capacity
    tables.sum(:capacity)
  end

  def guests_at_datetime(datetime)
    total_guests = reservations.where(Reservation.arel_table[:start_datetime].lteq(datetime))
                               .where(Reservation.arel_table[:end_datetime].gteq(datetime))
                               .sum(:total_guests)

    total_guests
  end

  def max_availability_within_span(start_datetime, end_datetime)
    start_availability = capacity - guests_at_datetime(start_datetime)
    end_availability = capacity - guests_at_datetime(end_datetime)

    availability = [start_availability, end_availability].min

    # Handle if availability is negative
    [0, availability].max
  end
end
