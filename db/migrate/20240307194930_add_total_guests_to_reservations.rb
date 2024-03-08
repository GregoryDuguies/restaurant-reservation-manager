class AddTotalGuestsToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :total_guests, :bigint
  end
end
