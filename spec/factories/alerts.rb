FactoryGirl.define do
  factory :alert do
    currency "MyString"
    currency_value "9.99"
    user_min 1
    user_max 1
    time_value "MyString"
    direction "MyString"
    crypto_id "MyString"
    user nil
  end
end
