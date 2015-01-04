require 'rails_helper'

RSpec.describe 'Calendar', :type => :feature, :us => true do
  let(:event){ create :event }

  before(:each) do
    setup_store
  end

  describe 'Month' do
    describe 'Events on the Month' do
      it 'should list 2, and then offer a more... option' do
        events = []
        3.times do
          events << FactoryGirl.create(:event, :starts_at => Date.today)
        end

        visit '/events?calendar_view=month'

        within('.today') do
          all('li').first.should have_content(events[0].name)
          all('li')[1].should have_content(events[1].name)
          all('li').last.should have_content('more...')
        end
      end
    end

  end

  describe 'Week' do

  end

  describe 'Day' do

  end
end