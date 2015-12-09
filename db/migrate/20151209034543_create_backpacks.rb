class CreateBackpacks < ActiveRecord::Migration
  def change
    create_table :backpacks do |t|

      t.timestamps null: false
    end
  end
end
