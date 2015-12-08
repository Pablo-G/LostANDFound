class AddValidationCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :validation_code, :integer
  end
end
