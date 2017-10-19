require 'bigdecimal/util'

  desc "User can receive alert based on a range"
  task :send_alert => :environment do
    @alerts = Alert.all
    @alerts.each do |alert|
      unless alert.expired?
        present_value = alert.get_value()
        new_percent_delta = alert.percent_changed
        if (alert.direction == "up" && (new_percent_delta > alert.alert_min)) || (alert.direction == "down" && (new_percent_delta < alert.alert_min))
          alert.send_message("#{alert.alert_currency} is currently #{alert.direction} by #{new_percent_delta.round(2)}%", alert.user)
        end
      end
    end
  end