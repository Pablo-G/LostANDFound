class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer, default: User::USER
  end
end
