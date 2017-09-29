class AddTimeIntervalToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_column :alerts, :time_interval, :string
  end
end
