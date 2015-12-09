class RemoveValidatedFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :validated, :string
  end
end
