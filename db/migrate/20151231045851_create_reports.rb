class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      	t.integer :ticket_id
      	t.integer :user_id
      	t.boolean :status
      	t.integer :type
      	t.text :message

      t.timestamps null: false
    end
  end
end
