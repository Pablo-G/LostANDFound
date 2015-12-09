class RemoveCategoryFromLostObject < ActiveRecord::Migration
  def change
    remove_column :lost_objects, :category, :string
  end
end
