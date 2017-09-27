require 'rails_helper'

RSpec.describe "UserLogins", type: :request do
  describe "GET /user_logins" do
    it "login with invalid information" do
      user = attributes_for(:user)
      # make a GET login_path request
      get login_path
      # testing for correct template to render after GET login_path
      expect(response).to render_template('sessions/new')
      # testing a post request with invalid email
      post login_path, params: { :session => {:email => " ", :password => user[:password] }}
      # test for correct template to render after POST login_path with invalid parameters
      expect(response).to render_template("sessions/new")
      # test for presence of flash[warning]
      expect(flash[:danger]).to be_present
    end
end
end