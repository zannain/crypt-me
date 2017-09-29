class CreateAlerts < ActiveRecord::Migration[5.1]
  def change
    create_table :alerts do |t|
      t.string :currency
      t.decimal :currency_value
      t.integer :user_min
      t.integer :user_max
      t.string :time_value
      t.string :direction
      t.string :crypto_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
