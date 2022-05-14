FactoryBot.define do
  factory :gallery do
    association :user
    name { Faker::Name.name }
    short_description { Faker::Lorem.word }
  end
end
