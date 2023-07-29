class RemoveBillingAmountFromReservation < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :billing_amount, :integer
  end
end
