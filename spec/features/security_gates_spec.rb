require 'rails_helper'

RSpec.describe 'Security Gate Requests', :type => :feature do
  before(:each) do
    setup_store
  end

  describe 'News Story Requests' do
    describe 'New/Edit Form' do
      it 'New Form should show Author selector if :admin or higher is signed in' do
        admin = manual_login_as(:admin)
        visit 'news_stories/new'
        expect(page).to have_select('Author')
      end

       specify 'Select should default to current_user name, if :admin or higher' do
        admin = manual_login_as(:admin)
        visit 'news_stories/new'
        expect(page).to have_select('Author', :selected => admin.name)
       end

      specify 'New Form should NOT show Author selector if :admin or higher is signed in' do
        staff = manual_login_as(:staff)
        visit 'news_stories/new'
        expect(page).not_to have_select('author_id')
      end

      specify 'Page should have hidden field for author if lower User is lower than :admin' do
        staff = manual_login_as(:staff)
        visit 'news_stories/new'
        page.find(:css, '#news_story_author_id').value.should == staff.id.to_s
      end
    end
   end
end
