class RemoveMenuIdFromReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :menu_id, :integer
  end
end
