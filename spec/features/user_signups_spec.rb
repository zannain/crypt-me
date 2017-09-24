require 'rails_helper'

RSpec.feature "UserSignups", type: :feature do
  scenario "User signs up with out a name" do
    @user = FactoryGirl.create(:user)
    visit new_user_path
    fill_in "Email", with: @user.email
    fill_in 'Password', with: @user.password
    fill_in 'Password confirmation', with: @user.password_confirmation
    click_button 'Create my account'
    expect(page).to have_content("Name can't be blank")
  end
  scenario "User signs up with out an email" do
    @user = FactoryGirl.create(:user)    
    visit new_user_path
    fill_in "Name", with: @user.name
    fill_in 'Password', with: @user.password
    fill_in 'Password confirmation', with: @user.password_confirmation
    click_button 'Create my account'
    expect(page).to have_content("Email can't be blank")
  end
  scenario "User signs up with out a password" do
    @user = FactoryGirl.create(:user)    
    visit new_user_path
    fill_in "Name", with: @user.name
    fill_in "Email", with: @user.email    
    fill_in 'Password confirmation', with: @user.password_confirmation
    click_button 'Create my account'
    expect(page).to have_content("Password can't be blank")
  end
  scenario "User password and password confirmation do not match" do
    @user = FactoryGirl.create(:user)    
    visit new_user_path
    fill_in "Name", with: @user.name
    fill_in "Email", with: @user.email    
    fill_in 'Password', with: @user.password    
    fill_in 'Password confirmation', with: 'hello'
    click_button 'Create my account'
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

end