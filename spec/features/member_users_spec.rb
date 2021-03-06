require 'rails_helper'

RSpec.describe 'Member Users', :type => :feature do
  before(:each) do
    setup_store
  end
  let!(:gym){ create :gym }
  #Members use typical Devise routes
  #User sign up is not implemented at this time

  #describe 'Signing Up as an unknown user' do
  #  it 'A newly created user has :member level' do
  #    visit '/'
  #    click_link 'Sign Up'
  #    fill_in 'Email', :with => '123@gmail.com'
  #    fill_in 'Password', :with => 'carltonlasiter'
  #    fill_in 'Password confirmation', :with => 'carltonlasiter'
  #    within('.new_user') do
  #      expect{ click_button 'Sign up' }.to change{ User.count }.by(1)
  #    end
  #  end
  #end

  describe 'User Requests' do
    specify ':members cannot access User request, except through Devise' do
      member = manual_login_as(:member)
      visit '/users/new'
      current_path.should == '/'
    end

    specify 'unknown users cannot access User request, except through Devise' do
      visit '/users/new'
      current_path.should == '/'
    end
  end

end