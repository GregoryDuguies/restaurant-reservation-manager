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
  # before_create :set_end_datetime

  # ASSUMPTION: Allocate time at table to 2 hours?
  # def set_end_datetime
  #   self.end_datetime = start_datetime + 2.hours
  # end

  def allocate_tables_v1
    # Find tables for restaurant at given time
    available_table_ids = restaurant.available_tables_at_datetime(start_datetime).union(restaurant.available_tables_at_datetime(end_datetime))

    large_enough_tables = Table.where(id: available_table_ids).where(Table.arel_table[:capacity].gteq(total_guests))

    if large_enough_tables.any?
      reservation_table = self.reservation_tables.build(table: large_enough_tables.first)

      reservation_table.save!
    else
      Table.where(id: available_table_ids).order(capacity: :desc).each do |table|
        next unless total_guests > reservation_tables.joins(:table).sum(:capacity)

        reservation_table = self.reservation_tables.build(table: table)
        reservation_table.save!
      end
    end
  end
end
