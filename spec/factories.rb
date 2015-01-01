FactoryGirl.define do
  sequence(:email){ |n| "test#{n}@test.com" }

  trait :human_names do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end

  factory :address do
    factory :address_full do
      #there is no validation to justify this factory. It needs to be built into farmtools
      street Faker::Address.street_name
      city Faker::Address.city
      state Faker::Address.state
      zip Faker::Address.zip_code
    end
  end


  factory :news_story do
    title Faker::Company.catch_phrase.titlecase
    association :author, :factory => :staff_plus

    factory :published do
      published true
    end

    factory :draft do
    end

     factory :archive do
       archived true
     end
  end

  factory :gym do
    name Faker::Company.name
    email
    phone Faker::PhoneNumber.phone_number
    association :address, :factory => :address_full
  end

  factory :user do
    email { generate(:email) }
    password "carltonlasiter"
    level User::USER_LEVELS.sample

    factory :member do
      level :member
    end


    factory :staff do
      human_names
      level :staff
    end

    factory :admin do
      human_names
      level :admin
    end

    factory :owner do
      human_names
      level :owner
    end

    factory :staff_plus do
      human_names
      level User::AFFILIATED_LEVELS.sample
    end

  end

  factory :event_category do
    name Faker::Company.catch_phrase
  end

  factory :event do
    event_date = Random.rand(1.50000).minutes.until
    name Faker::Company.bs
    starts_at event_date
    event_category
    reoccurs_every Event::REOCCURRENCE_TYPES.sample

    #event is any event EXCEPT a :class
    events = Event::EVENT_TYPES.dup
    events.delete(:class)
    event_type events.sample



    factory :class do
      event_type :class
      association :user, :factory => User::AFFILIATED_LEVELS.sample
      ends_at event_date + [30, 45, 60, 75, 90].sample.minutes
    end

    factory :appointment do
      event_type :appointment

    end
  end

end