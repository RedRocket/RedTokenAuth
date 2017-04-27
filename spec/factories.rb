FactoryGirl.define do
  factory :user do
    sequence(:email)      { |i| "email_#{i}@email.com" }
    password              "abcd1234"
    password_confirmation "abcd1234"
  end
end
