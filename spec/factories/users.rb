FactoryGirl.define do
  factory :user do
    email 'jane.doe@test.com'
    password 'password'
    confirmed_at Time.now
  end
end
