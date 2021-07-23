FactoryBot.define do
    factory :comment do
      content { Faker::Lorem.word }
      created_by { Faker::Number.number(10) }
      likes { Faker::Number.number(10) }
      project_id nil
    end
  end