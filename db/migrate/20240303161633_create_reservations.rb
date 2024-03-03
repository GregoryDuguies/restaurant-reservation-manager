class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :table
      t.belongs_to :restaurant

      t.string     :owner_name
      t.string     :owner_phone_number

      t.datetime   :start_datetime

      t.timestamps
    end
  end
end
