FactoryBot.define do
    factory :project do
      title { Faker::Lorem.word }
      description { Faker::Lorem.word }
      created_by { Faker::Number.number(10) }
      likes { Faker::Number.number(10) }
      images { [Faker::Lorem.word, Faker::Lorem.word ] }
    end
  end