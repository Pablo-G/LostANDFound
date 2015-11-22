class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :gender
      t.integer :age

      # Campos para Authlogic
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token

      t.timestamps null: false
    end

    # Se va a buscar a los usuarios por e-mail
    add_index :users, :email, unique: true
  end
end
