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
      first_name Faker::Name.first_name
      last_name Faker::Name.last_name
      level :staff
    end

    factory :admin do
      first_name Faker::Name.first_name
      last_name Faker::Name.last_name
      level :admin
    end

    factory :owner do
      first_name Faker::Name.first_name
      last_name Faker::Name.last_name
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
      association :user, :factory => :staff
      ends_at event_date + [30, 45, 60, 75, 90].sample.minutes
    end
  end

end