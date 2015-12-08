class RemoveValidatedFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :validated, :boolean
  end
end
