require 'bigdecimal/util'

namespace :alerts do
  desc "User can receive alert based on MAX_NEW value"
  task min: :environment do
    @alerts = Alert.all
    @alerts.each do |alert|
      unless alert.expired?
        present_value = alert.get_value(self)
        new_percent_delta = alert.percent_changed
        if (alert.direction == "up" && (new_percent_delta > alert.alert_min)) || (alert.direction == "down" && (new_percent_delta < alert.alert_min))
          puts "#{alert.currency} is currently #{alert.direction} by #{new_percent_delta}%"
          alert.send_message("#{alert.currency} is currently #{alert.direction} by #{new_percent_delta}%")          
        end
      end
     end
   end
end

