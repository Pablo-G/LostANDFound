class ChangeObjectLocationToReference < ActiveRecord::Migration
  def change
    change_table :lost_objects do |t|
      t.remove :location
      t.references :location
    end
  end
end
