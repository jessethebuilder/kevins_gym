#require 'rails_helper'
#
#RSpec.describe 'Users', :type => :feature do
#  let!(:gym){ create :gym }
#  describe 'Signing Up as an unknown user' do
#    it 'A newly created user has :member level' do
#      visit '/'
#      click_link 'Sign Up'
#      fill_in 'Email', :with => '123@gmail.com'
#      fill_in 'Password', :with => 'carltonlasiter'
#      fill_in 'Password confirmation', :with => 'carltonlasiter'
#      click_link 'Sign Up'
#      #Perhaps change this to something a custom welcome message
#      #within('#the_flash') do
##      save_and_open_page
#        expect(page).to have_content "Welcome! You have signed up successfully."
#      #end
#
#    end
#
#  end
#
#end