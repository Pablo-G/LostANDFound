class RemoveValidationCodeFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :validation_code, :integer
    remove_column :users, :validated, :boolean
  end
end
