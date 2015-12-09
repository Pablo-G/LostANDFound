class CreateLaptops < ActiveRecord::Migration
  def change
    create_table :laptops do |t|
      t.string :brand
      t.string :model

      t.timestamps null: false
    end
  end
end
