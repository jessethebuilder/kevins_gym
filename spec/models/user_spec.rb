require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:member){ build :member }
  let(:owner){ build :owner }

  describe 'Validations' do
    it{ should validate_presence_of :level }
    it{ should validate_inclusion_of(:level).in_array(User::USER_LEVELS)}
  end

  describe 'Associations' do
    it{ should have_many(:classes).class_name('Event') }
  end

  describe 'Methods' do
    describe '#level_is_at_least(#level)' do
      #USER_LEVELS is described in initializers/globals.rb
      it "should return false parameter is greater than the user's" do
        member.level_is_at_least(:staff).should == false
        member.level_is_at_least(:admin).should == false
        member.level_is_at_least(:owner).should == false
      end

      it "should return true if the user's level is higher than or equal to the parameter" do
        owner.level_is_at_least(:staff).should == true
        owner.level_is_at_least(:owner).should == true
      end

      it 'should automatically convert strings to symbols' do
        owner.level_is_at_least('owner')
      end

      it 'should raise an error is the parameter is not a symbol' do
        expect{ member.level_is_at_least('f;lkasd11').to raise_error(ArgumentError) }
      end

    end
  end
end
