#require 'rails_helper'
#
#RSpec.describe 'News Story Requests', :type => :feature do
#  let!(:ns){ create :news_story }
#  before(:each) do
#    setup_store
#  end
#
#  describe 'Index' do
#
#  end
#
#  describe 'Show' do
#    before(:each) do
#    end
#
#    it 'should show a news story' do
#      visit "news_stories/#{ns.id}"
#      page.should have_content(ns.title)
#    end
#
#    it 'should show the story content' do
#      content = Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..10))
#      ns.content = content
#
#      visit "news_stories/#{ns.id}"
#      page.should have_content(content)
#    end
#  end
#
#  describe 'New' do
#    specify 'if user is of higher level than admin, Author select will have their name select' do
#      admin = FactoryGirl.create :admin
#      manual_login_as(admin)
#      visit "/news_stories/new"
#      page.should have_select('author_id', :selected => admin.id)
#    end
#
#    specify 'if user is of a lower level than admin, no Author select shows' do
#      staff = FactoryGirl.create :staff
#      manual_login_as(staff)
#      visit "/news_stories/new"
#      page.should_not have_select('Author')
#    end
#
#    specify 'Delete button should NOT be visible' do
#      page.should_not have_link('Delete')
#    end
#
#  end
#
#  describe 'Edit' do
#    #----------------save_draft_archive_delete ---------------------------------------------
#    specify 'Delete button should be visible' do
#      page.should have_link('Delete')
#    end
#
#    specify 'Publish button should set :published to true and :archived to false' do
#      visit "/news_stories/#{ns.id}/edit"
#      click 'Publish'
#      ns.published.should == true
#      ns.archived.should == false
#    end
#
#    specify 'Draft button should set :published to false and :archived to false' do
#      visit "/news_stories/#{ns.id}/edit"
#      click_button 'Save Draft'
#      ns.published.should == false
#      ns.archived.should == false
#    end
#
#    #specify 'Archive button should set :published to false and :archived to true' do
#    #  visit "/news_stories/#{ns.id}/edit"
#    #  page.accept_alert "Archived News Stories will not appear on site. Are you sure?" do
#    #    click_button 'Archive'
#    #  end
#    #  ns.published.should == false
#    #  ns.archived.should == true
#    #end
#    #
#    #specify  'Delete button should delete the record' do
#    #  visit "/news_stories/#{ns.id}/edit"
#    #  page.accept_alert "This will delete #{ns.title} permanently. Are you sure?" do
#    #    click_link 'Delete'
#    #  end
#    #  ns.deleted?.should == true
#    #end
#    #----------------end save_draft_archive_delete ----------------------------------------
#
#    specify 'if current_user is admin or higher, show select box for author WITH authors name showing' do
#      #this contrasts with a similar spec in the New action,
#      #in which the same select has the current_user's name selected
#      admin = FactoryGirl.create :admin
#      manual_login_as(admin)
#      visit "/news_stories/#{ns.id}/edit"
#      page.should have_select('Author', :selected => ns.author.id)
#    end
#
#    specify 'if current_user is of lower level than admin, no Author select will show' do
#      staff = FactoryGirl.create :staff
#      manual_login_as(staff)
#      visit "/news_stories/#{ns.id}/edit"
#      page.should_not have_select('Author')
#    end
#
#  end #end Edit
#
#
#
#end