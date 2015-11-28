class CreateLostObjects < ActiveRecord::Migration
  def change
    create_table :lost_objects do |t|
      t.string :name
      t.string :type
      t.string :location
      t.text :description
      t.integer :userID
      t.boolean :state
      t.date :dateAdded
      
      # Campo para paperclip
      #has_attached_file :image
      
      t.timestamps null: false
    end
    
    #add_attachment :lost_objects, :image
  end
end
