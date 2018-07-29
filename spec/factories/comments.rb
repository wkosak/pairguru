FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    user
    movie
  end
end
