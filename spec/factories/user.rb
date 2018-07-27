FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Lorem.name }
    password { 'password' }
    confirmed_at { Time.zone.now }

  end
end
