FactoryBot.define do
  factory :user, class: User do
    first_name       { Faker::Name.first_name }
    last_name        { Faker::Name.last_name }
    email            { Faker::Internet.email }
    password         { Faker::Internet.password(min_length: 8) }

    factory :admin do
      after(:create) {|user| user.add_role(:admin)}
    end

    factory :api do
      after(:create) {|user| user.add_role(:api)}
    end
  end
end