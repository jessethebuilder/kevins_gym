@pw = 'carltonlasiter'
require 'action_view/helpers'

include ActionView::Helpers

g = Gym.new :name => "Super Gym", :phone => "360-670-9312", :email => "jesse@anysoft.us"
g.build_contact_info.address = Address.new :street => '4218 Mt. Angeles Rd', :city => 'Port Angeles', :state => 'wa', :zip => '98362'
g.save!

snp = g.contact_info.build_social_networking_profile
snp.facebook_url = "https://www.facebook.com/AnysoftSoftwareCompany?ref=hl"
snp.twitter_url = "https://twitter.com/anysoftdotus?lang=en"
snp.pinterest_url = "https://www.pinterest.com/anysoft/"
snp.tumblr_url = "http://anysoft-software.tumblr.com/"
snp.save!
#
#4.times do
#  u = User.new :first_name => Faker::Name.first_name, :last_name => Faker::Name.last_name,
#               :email => Faker::Internet.email, :password => @pw, :level => :staff
#  #u.avatar.store!(File.open(File.join(Rails.root, 'app', 'assets', 'images', 'temp', 'user_sample1.jpg')))
#  u.save!
#end

3.times do |n|
  #a bunch of random users
  u = User.new :email => "#{n}_#{Faker::Internet.email}", :password => @pw, :level => 'staff', :skills => [User::SKILLS.sample]
  unless u.level == 'member' && Random.rand(1..4) != 1
    u.first_name = Faker::Name.first_name
    u.last_name = Faker::Name.last_name
  end

  # url = helper.image_url("temp/user_sample#{Random.rand(1..2)}")
  # e.main_image = File.new(fn)
  # u.remote_avatar_url = url
  #
  fn = File.join(Rails.root, "app/assets/images/temp/user_sample#{Random.rand(1..2)}.jpg")
  u.avatar = File.new(fn)



  u.bio = Faker::Lorem.sentences(sentence_count = Random.rand(1..10)).join('<p>'.html_safe)
  u.save!
end

admin = User.create! :email => 'admin@test.com', :password => @pw, :first_name => 'Jesse', :last_name => 'Farmer',
                     :level => 'admin', :bio => 'The builder of this site. The builder!!', :skills => [User::SKILLS.sample]
admin.avatar = File.new(File.join(Rails.root, 'app/assets/images/temp/user_sample1.jpg'))
admin.save!

4.times do
  ec = EventCategory.new :name => Faker::Company.name, :description => Faker::Company.bs
  ec.save!
end

6.times do
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
  description = [des_start, des_items, des_end].join('<p>'.html_safe)

  e = Event.new :name => Faker::Company.name, :starts_at => time, :ends_at => time + [15, 30, 45, 60, 75, 90].sample.minutes,
                :event_type => 'class', :description => description
  e.user = User.affiliated.sample
  e.event_category = EventCategory.all.sample
  e.reoccurs_every = Event::REOCCURRENCE_TYPES.sample

  #setup main_image
  fn = File.join(Rails.root, 'app/assets/images/temp', "class_sample#{Random.rand(1..3)}.jpg")
  # url = helper.image_url("temp/class_sample#{Random.rand(1..3)}")
  e.main_image = File.new(fn)
  # e.remote_main_image_url = url

  e.save!

end

6.times do
  ns = NewsStory.new :title => Faker::Company.bs.titlecase, :published => true,
                     :content => Faker::Lorem.paragraphs(paragraph_count = Random.rand(3..20)).join('<p>')
  fn = File.join(Rails.root, 'app/assets/images/temp', "news_sample#{Random.rand(1..6)}.jpg")
  ns.main_news_story_image = File.new(fn)
  # url = helper.image_url("temp/news_sample#{Random.rand(1..6)}")
  # ns.remote_main_news_story_image_url = url
  ns.save!
  User.where.not(:level => 'member').sample.news_stories << ns

end

