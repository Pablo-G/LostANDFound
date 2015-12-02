class AddAttachmentImageToLostObjects < ActiveRecord::Migration
  def self.up
    change_table :lost_objects do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :lost_objects, :image
  end
end
