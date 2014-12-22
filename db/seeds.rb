g = Gym.new :name => "Kevin's Gym", :phone => "360-555-1212", :email => "gym@test.com"
g.address = Address.new :street => '4218 S. Mt. Angeles Rd', :city => 'Port Angeles', :state => 'wa', :zip => '98362'
g.save!

30.times do
  day = Time.now - 15.days + Random.rand(1..30).days
  e = Event.new :name => Faker::Company.name, :starts_at => day, :ends_at => day + [15, 30, 45, 60, 75, 90].sample.minutes,
                :event_type => :class
  e.save!
end
