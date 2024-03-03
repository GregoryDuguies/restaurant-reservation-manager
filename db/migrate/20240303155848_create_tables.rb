class CreateTables < ActiveRecord::Migration[7.1]
  def change
    create_table :tables do |t|
      t.belongs_to :restaurant

      t.bigint     :number
      t.bigint     :capacity

      t.timestamps
    end
  end
end
