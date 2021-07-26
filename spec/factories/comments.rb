FactoryBot.define do
    factory :comment do
      content { Faker::Lorem.word }
      created_by { Faker::Number.number(digits: 3) }
      likes { Faker::Number.number(digits: 3) }
      project_id nil
    end
  end