class AddValidatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :validated, :boolean, :null => false, :default => false
  end
end
