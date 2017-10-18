class CreateAlerts < ActiveRecord::Migration[5.1]
  def change
    create_table :alerts do |t|
      t.string :alert_currency
      t.decimal :alert_value
      t.datetime :alert_expiration
      t.string :alert_id
      t.integer :alert_min
      t.integer :alert_max
      t.string :direction
      t.references :user, foreign_key: true
    t.timestamps
    end
  end
end
