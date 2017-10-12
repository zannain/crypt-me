class StaticController < ApplicationController
	before_action :new_user, only: [:index]
  def index
  end

  private
  def new_user
  	@user = User.new
  end
end
