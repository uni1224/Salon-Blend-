class AddStatusToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :status, :string, default: '来院前'
  end
end
