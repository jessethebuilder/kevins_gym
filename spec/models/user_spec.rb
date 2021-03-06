require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:member){ build :member }
  let(:staff){ build :staff }
  let(:admin){ build :admin }

  describe 'Validations' do

    specify 'adds error if a skill is not in list' do
      #todo
    end

    it 'should validate presence of level' do
      member.level = nil
      member.save
      member.errors.messages[:level].include?('cannot be blank').should == true
    end

    #it{ should validate_inclusion_of(:level).in_array(symbols_and_strings(User::USER_LEVELS))}

    it 'should be invalid if of #level :staff or higher if no first_name' do
      admin.first_name = nil
      admin.valid?
      admin.errors.messages[:first_name].include?('cannot be blank').should == true

      admin.level = 'staff'
      admin.valid?
      admin.errors.messages[:first_name].include?('cannot be blank').should == true
    end

    it 'should be invalid if of #level :staff or higher if no last_name' do
      admin.last_name = nil
      admin.valid?
      admin.errors.messages[:last_name].include?('cannot be blank').should == true
    end
  end

  describe 'Associations' do
    it{ should have_many(:events) }
    it{ should have_many(:news_stories) }
  end

  describe 'Methods' do


    describe '#classes' do
      let!(:cl1){ create :class }
      let!(:cl2){ create :class }
      let!(:apt){ create :appointment }

      it 'should return a list of classes for the user' do
        staff.events << cl1
        staff.events << cl2
        staff.save
        staff.classes.count.should == 2
      end

      it 'should not return appointments' do
        staff.events << cl1
        staff.events << apt
        staff.save
        staff.classes.count.should == 1
      end

      it 'should not return classes for other users' do
        new_staff = FactoryGirl.create :staff
        new_staff.events << cl1
        staff.events << cl2
        staff.save

        new_staff.classes.count.should == 1
        new_staff.classes.first.should == cl1

        staff.classes.count.should == 1
        staff.classes.first.should == cl2
      end
    end

    describe '#level_is_at_least(#level)' do
      #USER_LEVELS is described in initializers/globals.rb
      it "should return false parameter is greater than the user's" do
        member.level_is_at_least('staff').should == false
        member.level_is_at_least('admin').should == false
        member.level_is_at_least('admin').should == false
      end

      it "should return true if the user's level is higher than or equal to the parameter" do
        admin.level_is_at_least('staff').should == true
        admin.level_is_at_least('admin').should == true
      end

      it 'should raise an error is the parameter is not a valid value' do
        expect{ member.level_is_at_least('f;lkasd11').to raise_error(ArgumentError) }
      end

    end
  end

  describe 'Class Methods' do
    describe '#instructors' do
      it 'should return all staff with events of :event_type => :class' do
        s1 = FactoryGirl.create(:staff)
        s2 = FactoryGirl.create(:staff)
        s3 = FactoryGirl.create(:staff)

        s1.events << FactoryGirl.create(:class)
        s2.events << FactoryGirl.create(:appointment)

        User.instructors.count.should == 1
        User.instructors.first.should == s1
      end

      it 'should return only unique records' do
        s1 = FactoryGirl.create(:staff)

        s1.events << FactoryGirl.create(:class)
        s1.events << FactoryGirl.create(:class)

        User.instructors.count.should == 1
      end
    end
  end

  #describe UserLevel do
  #
  #end
end
