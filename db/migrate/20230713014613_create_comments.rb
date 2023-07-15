class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id, null: false
      t.integer :salon_id
      t.text :content, null: false

      t.timestamps
    end
  end
end
