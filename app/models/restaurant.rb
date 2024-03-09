class Restaurant < ApplicationRecord
  has_many :tables
  has_many :reservations

  validates :name, presence: true

  def capacity
    tables.sum(:capacity)
  end

  def guests_at_datetime(datetime)
    reservations.where(Reservation.arel_table[:start_datetime].lteq(datetime))
                .where(Reservation.arel_table[:end_datetime].gteq(datetime))
                .joins(reservation_tables: :table )
                .sum(:capacity)
  end

  def available_tables_at_datetime(datetime)
    occupied_table_ids = reservations.where(Reservation.arel_table[:start_datetime].lteq(datetime))
                                     .where(Reservation.arel_table[:end_datetime].gteq(datetime))
                                     .joins(reservation_tables: :table )
                                     .pluck('tables.id')

    tables.pluck(:id) - occupied_table_ids
  end

  def max_availability_within_span(start_datetime, end_datetime)
    start_availability = capacity - guests_at_datetime(start_datetime)
    end_availability = capacity - guests_at_datetime(end_datetime)

    availability = [start_availability, end_availability].min

    # Handle if availability is negative
    [0, availability].max
  end
end
