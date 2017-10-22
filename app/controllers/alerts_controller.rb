require 'bigdecimal/util'

class AlertsController < ApplicationController
  before_action :set_alert, only: [ :edit, :update, :destroy]
  before_action :new_alert, only: [:search, :new]
  before_action :set_user

  # search for a cryptocurrency
  def search
    @crypto = HTTParty.get("https://api.coinmarketcap.com/v1/ticker/?limit=100")
    @currency = params[:currency]
    @currency_value = params[:currency_value]
    @crypto_id = params[:crypto_id]
    @alerts = @user.alerts
    
  end

  # list current_user alerts
  def index
    @alerts  = current_user.alerts
  end

  # receives params for a new alert
  def create
    @alert = current_user.alerts.build(alert_params)
    if @alert.save!
      redirect_to search_path 
      flash.now[:success] = 'Alert was successfully created.'
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
      redirect_to alerts_path # 
      flash.now[:success] = "Alert Updated!"
    else
      render 'edit'
    end
  end
  # delete an alert based on params
  def destroy
    @alert.destroy
    redirect_to alerts_url #flash[:success] = "Alert Deleted!"
  end

  private
  # find a specific alert by params
  def set_user
    @user = current_user
  end
  def set_alert
    @alert = Alert.find(params[:id])
  end

  # create a new alert based on params
  def new_alert
    @alert = Alert.new(params[:id])
  end

  # alert parameters
  def alert_params
    params.require(:alert).permit(
      :display_min,
      :display_max,
      :alert_id,
      :created_at,
      :alert_currency,
      :alert_value,
      :alert_min,
      :alert_max,
      :alert_expiration,
    :direction, :alert_interval)
  end
end
