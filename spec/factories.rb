FactoryGirl.define do
  sequence(:email){ |n| "test#{n}@test.com" }

  factory :user do
    email { generate(:email) }
    password "carltonlasiter"

    factory :member do
      level :member
    end

    factory :staff do
      level :staff
    end

    factory :administrator do
      level :administrator
    end

    factory :owner do
      level :owner
    end

  end

  factory :event do
    name Faker::Company.bs
    starts_at Random.rand(1..50000).minutes.until
  end

end