FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 20) }
    email { Faker::Internet.email }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
  end

  factory :other_user do
    name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 20) }
    email { Faker::Internet.email }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
  end
end