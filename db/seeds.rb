@pw = 'carltonlasiter'

g = Gym.new :name => "Kevin's Gym", :phone => "360-555-1212", :email => "gym@test.com"
g.address = Address.new :street => '4218 S. Mt. Angeles Rd', :city => 'Port Angeles', :state => 'wa', :zip => '98362'
g.save!

4.times do
  u = User.new :first_name => Faker::Name.first_name, :last_name => Faker::Name.last_name,
               :email => Faker::Internet.email, :password => @pw, :level => :staff
  #u.avatar.store!(File.open(File.join(Rails.root, 'app', 'assets', 'images', 'temp', 'Shawn_Spencer.jpg')))
  u.save!
end

u = User.create! :email => 'j@test.com', :password => @pw, :first_name => 'Jesse', :last_name => 'Farmer',
                 :level => :admin

30.times do
  #a bunch of random users
  u = User.new :email => Faker::Internet.email, :password => @pw, :level => User::USER_LEVELS.sample
  unless u.level == :member && Random.rand(1..4) != 1
    u.first_name = Faker::Name.first_name
    u.last_name = Faker::Name.last_name
  end
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

  des_start = Faker::Lorem.sentences(sentence_count = Random.rand(1..6)).join(' ')
  des_items = ''
  Random.rand(1..5).times do
      des_items += "<li>#{Faker::Company.catch_phrase.titlecase}</li>"
  end
  des_end = Faker::Lorem.sentences(sentence_count = Random.rand(1..6)).join(' ')
  description = [des_start, des_items, des_end].join('<br>').html_safe

  e = Event.new :name => Faker::Company.name, :starts_at => time, :ends_at => time + [15, 30, 45, 60, 75, 90].sample.minutes,
                :event_type => :class, :description => description
  e.user = User.all.sample
  e.save!

end

30.times do
  ns = NewsStory.new :title => Faker::Company.bs.titlecase, :content => Faker::Lorem.paragraphs(paragraph_count = Random.rand(3..20)).join('<br>')
  ns.author = User.where.not(:level => 'member').sample
  ns.save!
end
