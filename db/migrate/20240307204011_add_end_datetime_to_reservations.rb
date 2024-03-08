class AddEndDatetimeToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :end_datetime, :datetime
  end
end
