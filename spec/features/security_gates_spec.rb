require 'rails_helper'

RSpec.describe 'Security Gate Requests', :type => :feature do
  before(:each) do
    setup_store
  end

  describe 'News Story Requests' do
    describe 'Index' do
      describe 'index_edit_story' do
        specify 'user user is not signed in, quick options should not show' do
          visit 'news_stories'
          page.should_not have(:css, 'ul.quick_options')
        end

        specify 'if user is of level :admin or above, it should should an edit link on every story' do
          manual_login_as(FactoryGirl.create :admin)
          visit 'news_stories'
          all('.news_story').each do |story|
            story.should have_css('.quick_options')
          end
        end

        specify 'if user is of level staff, then only stories they wrote should have an edit link' do
          staff = FactoryGirl.create :staff
          story = FactoryGirl.create :news_story
          story.author = staff
          story.save

          manual_login_as(staff)
          visit 'news_stories'

          1.should > 2
        end
      end
    end

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

  describe 'Event Requests' do
    specify 'if current_user is admin or above, there will be an (edit) link' do

    end

    specify 'if current user is staff, but the owner of the event, there will be an (edit) link' do

    end

    specify 'if user is of admin or above, they can visit /event/:id/edit' do

    end

    specify 'if user is the owner of an event, they can visit /event/:id/edit' do

    end

    specify 'if user is NOT the owner and of level :staff or lower, they CANNOT visit /event/:id/edit' do

    end
  end

end
