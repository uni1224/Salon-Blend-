class CreateResarvations < ActiveRecord::Migration[6.1]
  def change
    create_table :resarvations do |t|
      t.integer :user_id
      t.integer :menu_id
      t.datetime :day
      t.datetime :time
      t.integer :billing_amount

      t.timestamps
    end
  end
end
