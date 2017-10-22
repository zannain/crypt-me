require 'bigdecimal/util'
require 'twilio-ruby'
class Alert < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id
  validates_presence_of :alert_currency
  validates :alert_min, presence: true #, numericality: { only_integer: true, greater_than: 0 }
  validates :alert_max, presence: true #, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
  validates_presence_of :alert_id
  validates_presence_of :alert_interval
  validates_presence_of :alert_expiration
  validate :expired?

# Using the expiration_timestamp, compared aainst the present to determine if the alert has expired
def expired?
  self.alert_expiration < DateTime.now
end
  # gets the current value of the alert by querying the name of cryptocurrency
def get_value
  crypto = (HTTParty.get("https://api.coinmarketcap.com/v1/ticker/#{self.alert_id}/")).parsed_response
  crypto[0]['price_usd']
end

def percent_changed
    convert_to_decimal = BigDecimal(self.get_value)
    ((convert_to_decimal - self.alert_value)/self.alert_value)* 100
  end

def send_message(alert_message, number)
    @twilio_number = ENV["TWILIO_NUMBER"]
    @client = Twilio::REST::Client.new ENV["TWILIO_SID"],ENV["TWILIO_TOKEN"]

    @client.api.account.messages.create(
      :from => @twilio_number,
      :to => number,
      :body => alert_message,
    )
  end

def alert_range_check
  if alert_min > alert_max
    errors.add(:alert_min, "must be less than alert max percentage")
  else
    return true
  end
end
end
