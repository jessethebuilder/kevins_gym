require 'rails_helper'

RSpec.describe "gyms/index", :type => :view do
  before(:each) do
    assign(:gyms, [
      Gym.create!(
        :name => "Name",
        :phone => "Phone",
        :email => "Email",
        :fax => "Fax"
      ),
      Gym.create!(
        :name => "Name",
        :phone => "Phone",
        :email => "Email",
        :fax => "Fax"
      )
    ])
  end

  it "renders a list of gyms" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Fax".to_s, :count => 2
  end
end
