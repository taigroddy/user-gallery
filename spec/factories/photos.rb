FactoryBot.define do
  factory :photo do
    association :gallery
    name { Faker::Name.name }
    shooting_date { Faker::Time }
    short_description { Faker::Lorem.word }
    image { Rack::Test::UploadedFile.new('spec/fixtures/test-image.png', 'image/png') }
  end
end
