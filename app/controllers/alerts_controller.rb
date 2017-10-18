require 'bigdecimal/util'
class AlertsController < ApplicationController
  before_action :all_alerts, only: [:index]
  before_action :set_alert, only: [:show, :edit, :update, :destroy]
  before_action :new_alert, only: [:search, :new]
  before_action :logged_in_user

  # search for a cryptocurrency
  def search
    @crypto = HTTParty.get("https://api.coinmarketcap.com/v1/ticker/?limit=10")
    @currency = params[:currency]
    @currency_value = params[:currency_value]
    @crypto_id = params[:crypto_id]
  end

  # list current_user alerts
  def index
  end

  # receives params for a new alert
  def create
    @alert = current_user.alerts.build(alert_params)
    if @alert.save!
      redirect_to search_path, notice: 'Alert was successfully created.'
    else
      render :new
    end
  end

  # creates a new alert
  def new
    @currency = params[:currency]
    @currency_value = params[:currency_value]
    @crypto_id = params[:crypto_id]
  end

  def edit
  end

  def show
  end
  # update a alert
  def update
    if @alert.update_attributes(alert_params)
      redirect_to alerts_path, :notice => "Alert Updated!"
    else
      render 'edit'
    end
  end
  # delete an alert based on params
  def destroy
    @alert.destroy(alert_params)
    redirect_to alerts_url, :notice => "Alert Deleted!"
  end

  private
  # # find a specific alert by params
  def set_alert
    @alert = Alert.find(params[:id])
  end

  # create a new alert based on params
  def new_alert
    @alert = Alert.new(params[:id])
  end

  # get all alerts
  def all_alerts
    @alerts = Alert.all
  end

  # alert parameters
  def alert_params
    params.require(:alert).permit(
      :crypto_id,
      :created_at,
      :currency,
      :currency_value,
      :alert_min,
      :alert_max,
      :alert_expiration,
    :direction, :alert_interval)
  end

  def correct_user
    @alert = current_user.alerts.find_by(id: params[:id])
    redirect_to root_url if @alert.nil?
  end
end
