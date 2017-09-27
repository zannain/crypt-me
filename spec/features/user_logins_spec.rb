require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  it "login with valid information" do
    user = build(:user)
    user.save
    get login_path
    expect(response).to render_template("sessions/new")
    # post login_path, params: { :session => {:email => user[:email], :password => "password" }}
    # expect(response).to redirect_to(user_path(user))
    # expect(flash[:success]).to be_present
  end
end
