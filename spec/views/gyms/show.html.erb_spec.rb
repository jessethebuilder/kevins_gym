require 'rails_helper'

RSpec.describe "gyms/show", :type => :view do
  before(:each) do
    @gym = assign(:gym, Gym.create!(
      :name => "Name",
      :phone => "Phone",
      :email => "Email",
      :fax => "Fax"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Fax/)
  end
end
