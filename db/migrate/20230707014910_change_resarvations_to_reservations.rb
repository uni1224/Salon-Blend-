class ChangeResarvationsToReservations < ActiveRecord::Migration[6.1]
  def change
    rename_table :resarvations, :reservations
  end
end
