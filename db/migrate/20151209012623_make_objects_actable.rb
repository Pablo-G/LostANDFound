class MakeObjectsActable < ActiveRecord::Migration
  def change
    change_table :lost_objects do |t|
      t.actable
    end
  end
end
