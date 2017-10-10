require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	test "invalid signup information" do
		get signup_path
		assert_no_difference "User.count" do
  		post users_path, params: { 
	  		user: {
	  			name: " ",
  				email: "@user.invalid",
  				phone_number: "1234568",
	  			password: "foo",
	  			password_confirmation: "bar"
	  		}	
	  	}
	  	end
	  assert_template 'users/new'
	  assert_select "div.alert"
	  assert_select "div.alert-danger"
	end

	test "valid signup information" do
		get signup_path
		assert_difference 'User.count', 1 do
			post users_path, params: {
				user: {
					name: "Test User",
					email: "user@example.com",
					phone_number: '5101234567',
					password: 'password',
					password_confirmation: 'password'
				}
			}
		end
		follow_redirect!
		assert_template 'users/show'
		assert is_logged_in?
	end
end

