FactoryGirl.define do
  factory :user do
    sequence(:email)      { |i| "email_#{i}@email.com" }
    password              "12345678"
    password_confirmation "12345678"
  end
end
