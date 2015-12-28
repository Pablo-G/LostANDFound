class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
    	t.integer :ticket_id
    	t.integer :user_id
    	t.date :created_at
    	t.text :message

      t.timestamps null: false
    end
  end
end
