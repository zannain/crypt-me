require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  it "save a new user" do
  get :new
  expect(response).to render_template("new")
  post :create , params: { user: attributes_for(:user) }
  expect(response).to redirect_to(:action => :show, :id=> assigns(:user).id)
  expect(User.count).to eq 1
  end
end
