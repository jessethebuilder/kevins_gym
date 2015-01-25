require 'rails_helper'

RSpec.describe Event, :type => :model, :js => false do
  let(:event){ build :event }
  let(:cl){ build :class }

  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :starts_at }
    it{ should validate_presence_of :event_type }
    it{ should validate_inclusion_of(:event_type).in_array(symbols_and_strings(Event::EVENT_TYPES)) }
    it{ should validate_inclusion_of(:reoccurs_every).in_array(Event::REOCCURRENCE_TYPES)}
    it{ should validate_presence_of(:reoccurs_every) }
    it{ should validate_presence_of(:duration) }

    it 'should validate that an event of type :class has a user' do
      cl.user = nil
      cl.valid?
      cl.errors.messages[:user_id].include?('class must have an instructor').should == true
    end

    #it{ should validate_presence_of :event_category_id }
  end

  describe 'Associations' do
    it{ should belong_to :user }
    it{ should belong_to :event_category }

  end

  describe 'Methods' do
    describe '#duration' do
      it 'should set ends_at val minutes after starts_at' do
        event.starts_at = Time.parse('1/1/2010 1:00pm')
        event.duration = 60
        #ends_at gets set with a filter, so the file must be saved here.
        event.save
        ends = event.ends_at.strftime('%d/%m/%Y').should == '01/01/2010'
        ends = event.ends_at.strftime('%I:%M%P').should == '02:00pm'
      end

      it 'should return the difference between starts_at and ends_at in minutes' do
        event.starts_at = Time.parse('1/1/2010 1:00pm')
        event.ends_at = Time.parse('1/1/2010 3:45pm')
        event.duration.should == 165
      end
    end

    describe '#reoccurs?' do
      it 'should return false if reoccurs_every is "never"' do
        event.reoccurs_every = "never"
        event.reoccurs?.should == false
      end

      it 'should return true if otherwise' do
        event.reoccurs_every = "week"
        event.reoccurs?.should == true

        event.reoccurs_every = "day"
        event.reoccurs?.should == true
      end
    end


  end

  describe 'Reoccuring Events' do
    let!(:weekly){ create :weekly_event }
    let!(:daily){ create :daily_event }

    describe 'Event.reoccuring' do
      it 'should return all classes for which #reoccurance_type is not "never"' do
        event.reoccurs_every = 'never'
        event.save
        Event.reoccuring.count.should == 2 #daily and weekly
      end
    end

    describe 'Event.reoccurances(from, till)' do
      before(:each) do
        t = Time.parse('1/1/2010 10:00am')
        weekly.starts_at = t
        weekly.save
      end

      it 'should return duplicates of reoccuring classes between the time-frame specified by from and till' do
        occurance = Event.reoccurences(Time.parse('1/1/2014'), Time.parse('7/1/2014') ).first
        occurance.starts_at.strftime('%A').should == weekly.starts_at.strftime('%A')
        occurance.starts_at.strftime('%R').should == weekly.starts_at.strftime('%R')
        occurance.new_record?.should == true
      end

      it 'should not return a new record if and where the original record occurs. It will return
          the original record' do
        occurance = Event.reoccurences(Time.parse('1/1/2010 8:00am'), Time.parse('1/1/2010 10:00am') ).first
        occurance.new_record?.should == false
      end

      specify 'from default now' do

      end
    end
  end

  describe 'Class Methods' do
    let!(:e1){ FactoryGirl.create :class, :starts_at => Time.parse('1/01/2010 1:00pm') }
    let!(:e2){ FactoryGirl.create :class, :starts_at => Time.parse('2/01/2010') }
    let!(:e3){ FactoryGirl.create :class, :starts_at => Time.parse('1/01/2010 2:00pm') }

    before(:each) do
      Timecop.freeze(Time.parse('31/12/2009'))
    end

    describe '#soonest_first' do
      it 'should return the newest event first' do
        #this works in field tests
        Event.soonest_first.first.should == e1
      end
    end

    describe '#upcoming_classes(days_count = 7)' do
      it 'should return a Hash' do
        Event.upcoming_classes.count.should == 2
        Event.upcoming_classes.class.should == Hash
      end

      specify 'keys should be parsable as dates' do
        Event.upcoming_classes.keys.first.should == ' 1/01/2010'
      end

      specify 'values should be an array of Events' do
        Event.upcoming_classes[' 1/01/2010'].class.should == Array
      end

      specify 'keys should be ordered by date, soonest first' do
        Event.upcoming_classes[' 1/01/2010'][0].should == e1
        Event.upcoming_classes[' 1/01/2010'][1].should == e3
      end

      it 'should return events for the number of days specified' do
        Event.upcoming_classes(1).count.should == 1
      end

      it 'should default to returning 7 days' do
        10.times do |i|
          #this functionality works, but I haven not been able to properly test for it
          FactoryGirl.create :class, :starts_at => Time.parse("#{i + 1}/1/2010")
        end
        Event.upcoming_classes.count.should == 7
      end

      it 'should only return events from today forward' do
        #timecop sets the current day at 31/12/2009
        old_class = FactoryGirl.create :class, :starts_at => Time.parse('30/12/2009')
        Event.upcoming_classes.count.should == 2
        Event.upcoming_classes.has_key?('30/12/2009').should == false
      end
    end





  end
end
