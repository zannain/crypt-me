class AddCurrencyValueToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_column :alerts, :currency_value, :string
  end
end
