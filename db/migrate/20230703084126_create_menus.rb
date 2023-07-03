class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.integer :salon_id
      t.string :title
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
