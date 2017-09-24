class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :password, :string
    add_column :users, :password_digest, :string
    add_column :users, :remember_digest, :string
    add_index :users, :email, unique: true
    add_index :users, :phone_number, unique: true
  end
end
