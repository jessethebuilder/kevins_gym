require 'rails_helper'

describe CalendarsHelper, :type => :helper do
  let(:event){ build :event }

  describe '#round_to_nearest_increment(date, increments = calendar_increments_in_minutes)' do
    it 'should round to nearest increment' do
      event.starts_at = Time.parse('7:10am')
      round_to_nearest_increment(event.starts_at, 30).should == '07:00am'

      event.starts_at = Time.parse('7:10am')
      round_to_nearest_increment(event.starts_at, 15).should == '07:15am'

      event.starts_at = Time.parse('7:39am')
      round_to_nearest_increment(event.starts_at, 30).should == '07:30am'

      event.starts_at = Time.parse('7:39am')
      round_to_nearest_increment(event.starts_at, 15).should == '07:45am'

      event.starts_at = Time.parse('7:30am')
      round_to_nearest_increment(event.starts_at, 60).should == '08:00am'

      event.starts_at = Time.parse('7:29am')
      round_to_nearest_increment(event.starts_at, 60).should == '07:00am'

      event.starts_at = Time.parse('7:00am')
      round_to_nearest_increment(event.starts_at, 15).should == '07:00am'
    end

    it 'works in the pm' do
      event.starts_at = Time.parse('11:38pm')
      round_to_nearest_increment(event.starts_at, 15).should == '11:45pm'
    end

    it 'works around midnight' do
      event.starts_at = Time.parse('11:46pm')
      round_to_nearest_increment(event.starts_at, 30).should == "12:00am"
    end

    it 'works around noon' do
      event.starts_at = Time.parse('11:31am')
      round_to_nearest_increment(event.starts_at, 60).should == "12:00pm"
    end


  end
end