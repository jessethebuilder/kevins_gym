g = Gym.new :name => "Kevin's Gym", :phone => "360-555-1212", :email => "gym@test.com"
g.address = Address.new :street => '4218 S. Mt. Angeles Rd', :city => 'Port Angeles', :state => 'wa', :zip => '98362'
g.save!

4.times do
  u = User.new :first_name => Faker::Name.first_name, :last_name => Faker::Name.last_name,
               :email => Faker::Internet.email, :password => 'carltonlasiter', :level => :staff
  u.save!
end

30.times do
  hour = Random.rand(6..20)
  if hour >= 12
    ampm = 'pm'
    hour = hour - 12 unless hour == 12
  else
    ampm = 'am'
  end

  minute = %w|00 15 30 45 13 29|.sample
  today = Date.today
  month = today.mon
  year = today.year
  day = (today - 15.days + Random.rand(1..30)).day
  time = Time.parse("#{day}/#{month}/#{year} #{hour}:#{minute}#{ampm}")

  e = Event.new :name => Faker::Company.name, :starts_at => time, :ends_at => time + [15, 30, 45, 60, 75, 90].sample.minutes,
                :event_type => :class, :description => Faker::Lorem.sentences(sentence_count = 5).join(' ')
  e.user = User.all.sample
  e.save!

end
