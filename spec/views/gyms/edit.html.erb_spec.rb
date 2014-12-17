require 'rails_helper'

RSpec.describe "gyms/edit", :type => :view do
  before(:each) do
    @gym = assign(:gym, Gym.create!(
      :name => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :fax => "MyString"
    ))
  end

  it "renders the edit gym form" do
    render

    assert_select "form[action=?][method=?]", gym_path(@gym), "post" do

      assert_select "input#gym_name[name=?]", "gym[name]"

      assert_select "input#gym_phone[name=?]", "gym[phone]"

      assert_select "input#gym_email[name=?]", "gym[email]"

      assert_select "input#gym_fax[name=?]", "gym[fax]"
    end
  end
end
