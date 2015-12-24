class AddColumnsToSpecificTypes < ActiveRecord::Migration
  def change
    add_column :backpacks, :size, :string
    add_column :backpacks, :brand, :string
    
    add_column :notebooks, :size, :string
    add_column :notebooks, :type, :string
    
    add_column :glasses, :brand, :string
    add_column :glasses, :sunglasses, :boolean

    add_column :laptops, :size, :string
  end
end
