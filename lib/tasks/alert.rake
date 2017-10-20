require 'bigdecimal/util'
require 'twilio-ruby'
namespace :alert do
  desc "User can receive alert based on a range"
  task :send_alert => :environment do
    @alerts = Alert.all
    @alerts.each do |alert|
      unless alert.expired?
        present_value = alert.get_value()
        new_percent_delta = alert.percent_changed
        number = "+1#{alert.user.phone_number}"
        if (alert.direction == "up" && (new_percent_delta > alert.alert_min)) || (alert.direction == "down" && (new_percent_delta < alert.alert_min))
          alert.send_message("#{alert.alert_currency} is currently #{alert.direction} by #{new_percent_delta.round(2)}%", number)
        end
      end
      alert.send_message("#{alert.alert_currency} is currently #{alert.direction} by #{new_percent_delta.round(2)}%", number)
    end
  end
  desc "Test Alert"
  task :test_alert => :environment do
    @client = Twilio::REST::Client.new(ENV["TWILIO_TEST_SID"],ENV["TWILIO_TEST_TOKEN"])
    message = @client.messages.create(
      to: '+15103660195',
      from: '+15005550006',
      body: 'Test alert'
    )
    puts message.sid
  end
end
