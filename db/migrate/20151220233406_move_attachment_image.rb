require_relative '20151202170939_add_attachment_image_to_lost_objects'

class MoveAttachmentImage < ActiveRecord::Migration
  def change
    revert AddAttachmentImageToLostObjects

    reversible do |dir|
      dir.up {
        change_table :images do |t|
          t.attachment :image
        end
      }
      dir.down {
        remove_attachment :images, :image
      }
    end
  end
end
