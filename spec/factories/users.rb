FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    phone_number Faker::PhoneNumber.cell_phone
    password'password'
    password_confirmation 'password'
  end
end