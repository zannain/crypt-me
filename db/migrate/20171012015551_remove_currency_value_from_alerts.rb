class RemoveCurrencyValueFromAlerts < ActiveRecord::Migration[5.1]
  def change
    remove_column :alerts, :currency_value, :decimal
  end
end
