require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  
  # User validation tests
  describe 'invalid user' do
    before(:each) do 
      @user = build(:user) 
    end
    # User should have a name
    it 'doesn\'t have a name' do
      @user.name = nil
      expect(@user).to_not be_valid
      expect(User.count).to eq 0
    end
    # User should have a name that is not to long (50 Char MAX)
    it 'name is not to long' do
      @user.name = 'a' * 51
      expect(@user).to_not be_valid
      @user.save
      expect(User.count).to eq 0 
    end
    # User should have an email
    it 'doesn\'t have an email' do
      @user.email = nil
      expect(@user).to_not be_valid
      @user.save
      expect(User.count).to eq 0      
    end
    # User email should should not be a duplicate
    it 'email address should be unique' do
      @user.save
      duplicate_user = @user.dup
      duplicate_user.phone_number = '5101234567'
      duplicate_user.email = @user.email
      duplicate_user.save
      expect(duplicate_user).to_not be_valid
      duplicate_user.save
      expect(User.count).to eq 1 
    end
    # User should have a valid email address
    it 'has a valid email address' do
      invalid_addresses = %w[
        user@example,com
        user_at_foo.org
        user.name@example.
        foo@bar_baz.com
        foo@bar+baz.com
      ]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to_not be_valid, "#{invalid_address.inspect}
        should be invalid"
        @user.save
        expect(User.count).to eq 0 
      end
    end
    # User email should not be too long (Max 255)
    it 'email should not be too long' do
      @user.email = 'a' * 244 + 'example.com'
      expect(@user).to_not be_valid
      @user.save
      expect(User.count).to eq 0 
    end
    # User email should be saved in lower case
    it 'email should be saved lower-cased' do
      mixed_case_email = 'tEsT@eXaMpLe.cOm'
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq(mixed_case_email.downcase)
      expect(User.count).to eq 1
    end
    # User should have a phone number
    it 'doesn\'t have a phone number' do
      @user.phone_number = nil
      expect(@user).to_not be_valid
      @user.save
      expect(User.count).to eq 0 
    end
    # User should have a unique phone number
    it "has a unique phone number" do
      @user.save
      @duplicate_user = build(:user, email: "test1@example.com")
      @duplicate_user.phone_number = @user.phone_number
      @duplicate_user.save
      expect(@duplicate_user).to_not be_valid
      @duplicate_user.save
      expect(User.count).to eq 1
    end
    # User should set a password
    it 'password should be present (not blank)' do
      @user.password = @user.password_confirmation = " " * 6
      expect(@user).to_not be_valid
      @user.save
      expect(User.count).to eq 0 
    end
    # Password should have a minimum length of 6
    it 'password should have a minimum length' do
      @user.password = @user.password_confirmation = 'a' * 5
      expect(@user).to_not be_valid
      @user.save
      expect(User.count).to eq 0 
    end
  end
end
