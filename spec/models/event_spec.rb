require 'rails_helper'

RSpec.describe Event, :type => :model do
  let(:event){ build :event }
  let(:cl){ build :class }

  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :starts_at }
    it{ should validate_presence_of :event_type }
    it{ should validate_inclusion_of(:event_type).in_array(symbols_and_strings(Event::EVENT_TYPES)) }
    it{ should validate_inclusion_of(:reoccurs_every).in_array(Event::REOCCURRENCE_TYPES)}
    it{ should validate_presence_of(:reoccurs_every) }

    it 'should validate presence of :ends_at IF :type == :class' do
      cl.ends_at = nil
      cl.valid?
      cl.errors.messages[:ends_at].include?('classes must have end time').should == true
    end

    it 'should validate that ends_at is AFTER starts_at' do
      cl.ends_at = event.starts_at - 15.minutes
      cl.valid?
      cl.errors.messages[:ends_at].include?('must be after start time').should == true
    end

    it 'should validate that an event of type :class has a user' do
      cl.user = nil
      cl.valid?
      cl.errors.messages[:user_id].include?('class must have an instructor').should == true
    end

    it{ should validate_presence_of :event_category_id }
  end

  describe 'Associations' do
    it{ should belong_to :user }
    it{ should belong_to :event_category }

  end

  describe 'Methods' do

  end

  describe 'Class Methods' do
    let!(:e1){ FactoryGirl.create :class, :starts_at => Time.parse('1/01/2010 1:00pm') }
    let!(:e2){ FactoryGirl.create :class, :starts_at => Time.parse('2/01/2010') }
    let!(:e3){ FactoryGirl.create :class, :starts_at => Time.parse('1/01/2010 2:00pm') }

    specify 'xxxx' do
      e3.valid?.should == true
    end

    before(:each) do
      Timecop.freeze(Time.parse('31/12/2009'))
    end

    describe '#soonest_first' do
      it 'should return the newest event first' do
        #this works in field tests
        Event.soonest_first.first.should == e3
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
