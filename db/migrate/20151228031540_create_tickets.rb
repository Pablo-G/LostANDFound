class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :lost_object_id
      t.integer :user_id
      t.boolean :status
      t.date :opened_at
      t.boolean :new_entry

      t.timestamps null: false
    end
  end
end
