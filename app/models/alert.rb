require 'bigdecimal/util'
require 'twilio-ruby'

class Alert < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :alert_currency, presence: true
  validates :alert_min, presence: true
  validates :alert_max, presence: true
  validates :alert_id, presence: true
  validates :alert_interval, presence: true
  validates :alert_expiration, presence: true
  validate :expired?

  # Compared user-defined expiration aainst the present DateTime to determine if the alert has expired
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
