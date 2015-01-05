require 'rails_helper'

RSpec.describe 'Users', :type => :feature do
  #let!(:gym){ create :gym }
  let(:user){ build :user }
  let(:staff){ build :staff }
  let(:admin){ create :admin }

  before(:each) do
    setup_store
  end

  describe 'Show' do
    before(:each) do
      staff.save
    end

    it 'should show a User' do
      visit "/users/#{staff.id}"
      within('.page_title') do
        page.should have_content(staff.name)
      end
    end
  end

  describe 'Index' do
    specify 'should keep current view between requests' do
      staff = manual_login_as(:staff)
      visit '/users'
      within('.quick_options') do
        click_link 'All Users'
      end

      visit '/'

      visit '/users'
      within('.quick_options') do
        page.should_not have_link('All Users')
        page.should have_link('Staff Users')
      end
    end

    specify 'View options should toggle between "Staff Users" and "All Users"' do
      staff = manual_login_as(:staff)
      visit '/users'
      within('.quick_options') do
        click_link 'All Users'
      end
      within('.quick_options') do
        page.should have_link 'Staff Users'
        click_link 'Staff Users'
      end
      within('.quick_options') do
        page.should have_link 'All Users'
      end
    end


  end

  describe 'users#edit' do
    it 'should go to users#index after a user is edited' do
      admin = manual_login_as(:admin)
      staff.save
      visit "/users/#{staff.id}/edit"
      click_button 'Update'
      current_path.should == '/users'
    end
   end

  it 'should render edit user with errors if user has validation errors' do
    admin = manual_login_as(:admin)

    visit "/users/#{admin.id}/edit"
    fill_in 'First name', :with => ''
    click_button 'Update'
    current_path.should == "/users/#{admin.id}"
    within('#error_explanation') do
      page.should have_content 'error kept this User'
    end
  end

  describe 'Destroy' do
    it 'should not let you destroy current user' do
      staff = manual_login_as(:staff)
      #todo
    end
  end


end

#module RequestsSpecHelper

#end