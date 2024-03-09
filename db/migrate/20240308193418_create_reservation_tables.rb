class CreateReservationTables < ActiveRecord::Migration[7.1]
  def change
    create_table :reservation_tables do |t|
      t.belongs_to :reservation
      t.belongs_to :table

      t.timestamps
    end
  end
end
