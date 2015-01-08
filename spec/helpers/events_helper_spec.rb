require 'rails_helper'

RSpec.describe EventsHelper, :type => :helper do
  let(:event){ build :event }

  describe '#event_time_in_words' do
    before(:each) do
      #1/1/2100 is a Friday
      event.starts_at = Time.parse('1/1/2100 9:00am')
    end
    #based on the #reoccurs_every attribute

    specify 'case never' do
      event.reoccurs_every = 'never'
      event_time_in_words(event).should == "Friday, January 1st at 9:00am"
    end

    specify 'case week' do
      event.reoccurs_every = 'week'
      event_time_in_words(event).should == 'Every Friday'
    end

    specify 'case day' do
      event.reoccurs_every = 'day'
      event_time_in_words(event).should == 'Every day at 9:00am'
    end

  end
end
#
#def event_time_in_words(event)
#  #todo spec
#  case event.reoccurs_every
#    when 'never'
#      "#{event.day_of_event}"
#    when 'week'
#      "Every #{event.day_name}"
#    when 'every_other_week'
#      "Every other week on #{event.day_name}"
#    when 'every_month_on_this_day'
#      day_position_in_month = (Integer(event.starts_at.strftime('%d')) / 7) + 1
#      "#{ActiveSupport::Inflector.ordinalize(day_position_in_month)} #{event.day_name} of every month"
#    when 'every_month_on_this_date'
#      "Every month on the #{ActiveSupport::Inflector.ordinalize(event.starts_at.strftime('%d'))}"
#  end
#end
