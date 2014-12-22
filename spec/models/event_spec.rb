require 'rails_helper'

RSpec.describe Event, :type => :model do
  let(:event){ build :event }
  let(:cl){ build :class }

  describe 'Validations' do
    it{ should validate_presence_of :name }

    it{ should validate_presence_of :starts_at }

    it{ should validate_presence_of :event_type }
    it{ should validate_inclusion_of(:event_type).in_array(Event::EVENT_TYPES) }

    it 'should validate presence of :ends_at IF :type == :class' do
      cl.ends_at = nil
      #has_errors?(cl, :ends_at, 'classes must have end time').should == true
      cl.valid?
      cl.errors.messages[:ends_at].include?('classes must have end time').should == true
    end

    it 'should validate that ends_at is AFTER starts_at' do
      cl.ends_at = event.starts_at - 15.minutes
      #has_errors?(cl, :ends_at, 'must be after start time').should == true
      cl.valid?
      cl.errors.messages[:ends_at].include?('must be after start time').should == true

      #event.save.should raise_error(:ends_at, 'must be after start time')
    end
  end

  describe 'Associations' do
    it{ should belong_to :user }

  end

  describe 'Methods' do

  end
end
