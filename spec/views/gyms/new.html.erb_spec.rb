require 'rails_helper'

RSpec.describe "gyms/new", :type => :view do
  before(:each) do
    assign(:gym, Gym.new(
      :name => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :fax => "MyString"
    ))
  end

  it "renders new gym form" do
    render

    assert_select "form[action=?][method=?]", gyms_path, "post" do

      assert_select "input#gym_name[name=?]", "gym[name]"

      assert_select "input#gym_phone[name=?]", "gym[phone]"

      assert_select "input#gym_email[name=?]", "gym[email]"

      assert_select "input#gym_fax[name=?]", "gym[fax]"
    end
  end
end
