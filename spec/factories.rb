FactoryGirl.define do
  sequence(:email){ |n| "test#{n}@test.com" }

  factory :gym do
    name Faker::Company.name
    email
    phone Faker::PhoneNumber.phone_number
  end

  factory :user do
    email { generate(:email) }
    password "carltonlasiter"
    level User::USER_LEVELS.sample

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
    event_date = Random.rand(1.50000).minutes.until
    name Faker::Company.bs
    starts_at event_date
    events = Event::EVENT_TYPES
    events.delete(:class)
    event_type events.sample

    factory :class do
      event_type :class
      ends_at event_date + [30, 45, 60, 75, 90].sample.minutes
    end
  end

end