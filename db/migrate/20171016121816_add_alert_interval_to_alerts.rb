class AddAlertIntervalToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_column :alerts, :alert_interval, :string
  end
end
