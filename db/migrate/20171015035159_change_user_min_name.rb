class ChangeUserMinName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :alerts, :user_min, :alert_min
  	rename_column :alerts, :user_max, :alert_max
  end
end
