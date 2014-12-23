g = Gym.new :name => "Kevin's Gym", :phone => "360-555-1212", :email => "gym@test.com"
g.address = Address.new :street => '4218 S. Mt. Angeles Rd', :city => 'Port Angeles', :state => 'wa', :zip => '98362'
g.save!

30.times do
  hour = Random.rand(6..20)
  if hour < 12
    ampm = 'am'
  else
    ampm = 'pm'
    hour = hour - 12
  end

  minute = %w|00 15 30 45 13 29|

  day = Time.parse("#{hour}:#{minute}#{ampm}")
  day = day - 15.days + Random.rand(1..30).days
  e = Event.new :name => Faker::Company.name, :starts_at => day, :ends_at => day + [15, 30, 45, 60, 75, 90].sample.minutes,
                :event_type => :class, :description => Faker::Lorem.sentences(sentence_count = 5).join(' ')
  e.save!
end
