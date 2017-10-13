require 'bigdecimal/util'

class Alert < ApplicationRecord
  validates_presence_of :user_min 
  # validates_presence_of :user_max 
  validates_presence_of :time_value
  validates_presence_of :direction 
  validates_presence_of :crypto_id
  belongs_to :user
  @cumulative = 0

# Using the expiration_timestamp, compared aainst the present to determine if the alert has expired
def expired?
 expiration_timestamp && (Time.now > expiration_timestamp)
end

# gets the current value of the alert by querying the name of cryptocurrency
def get_value(id)
  crypto = (HTTParty.get("https://api.coinmarketcap.com/v1/ticker/#{self.crypto_id}/")).parsed_response
  "$#{crypto[0]['price_usd']}"
end

  def percent_changed
    convert_to_decimal = self.get_value(self).delete('$').to_d
    ((convert_to_decimal - self.currency_value)/self.currency_value)* 100
  end

  #Checks interval set by user and sets an expiration interval
  def expiration_timestamp
    case time_interval
      when "hours" then Time.now + time_value.hours
      when 'days' then  Time.now + time_value.days
      when 'weeks' then  Time.now + time_value.weeks
    end
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