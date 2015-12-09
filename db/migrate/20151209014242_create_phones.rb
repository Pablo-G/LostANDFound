class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :brand
      t.string :model
      t.string :company
      t.boolean :case
      t.boolean :cracked_screen

      t.timestamps null: false
    end
  end
end
