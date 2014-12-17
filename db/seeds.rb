g = Gym.new :name => "Kevin's Gym", :phone => "360-555-1212", :email => "gym@test.com"
g.address = Address.new :street => '4218 S. Mt. Angeles Rd', :city => 'Port Angeles', :state => 'wa', :zip => '98362'
g.save!

3.times do
  e = Event.new :name => Faker::Business.name, :starts_at => Date.today
  e.save!
end
