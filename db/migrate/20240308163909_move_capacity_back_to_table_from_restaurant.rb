class MoveCapacityBackToTableFromRestaurant < ActiveRecord::Migration[7.1]
  def change
    remove_column :restaurants, :capacity

    add_column :tables, :capacity, :bigint
  end
end
