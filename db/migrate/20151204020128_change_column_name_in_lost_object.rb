# coding: utf-8
class ChangeColumnNameInLostObject < ActiveRecord::Migration
  def change
    # Cambiamos userID por user_id para seguir la convención
    # de la asosiación belongs_to, y cambiamos dateAdded por
    # date_added por consistencia con los demás nombres
    rename_column :lost_objects, :userID, :user_id
    rename_column :lost_objects, :dateAdded, :date_added
  end
end
