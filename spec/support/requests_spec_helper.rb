module RequestsSpecHelper
  def manual_login_as(level)
    u = FactoryGirl.create level, :password => 'testtest'
    visit '/d/users/sign_in'
    fill_in 'Email', :with => u.email
    fill_in 'Password', :with => 'testtest'
    click_button 'Log in'
  end
end