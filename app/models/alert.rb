require 'bigdecimal/util'
require 'twilio-ruby'

class Alert < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id
  validates_presence_of :alert_currency
  validates_presence_of :alert_min
  validates_presence_of :alert_max
  validates_presence_of :alert_id
  validates_presence_of :alert_interval
  validates_presence_of :alert_expiration
  
# Using the expiration_timestamp, compared aainst the present to determine if the alert has expired
def expired?
 self.alert_expiration > Time.now
end

# gets the current value of the alert by querying the name of cryptocurrency
def get_value(id)
  crypto = (HTTParty.get("https://api.coinmarketcap.com/v1/ticker/#{self.alert_id}/")).parsed_response
  "#{crypto[0]['price_usd']}"
end

  def percent_changed
    convert_to_decimal = self.get_value(self).to_d
    ((convert_to_decimal - self.alert_value)/self.alert_value)* 100
  end

  def send_message(alert_message)
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    @client.account.messages.create(
      :from => @twilio_number,
      :to => user.phone_number,
      :body => alert_message,
    )
  end
end

def get_value(id)
  crypto = (HTTParty.get("https://api.coinmarketcap.com/v1/ticker/#{id}/")).parsed_response
  "$#{crypto[0]['price_usd']}"
end