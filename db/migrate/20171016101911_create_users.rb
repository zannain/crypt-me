class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :password_digest
      t.string :remember_digest
      t.string :email, unique: true
      t.string :phone_number, unique: true
      t.string :country_code
    t.timestamps
  end
end
end

