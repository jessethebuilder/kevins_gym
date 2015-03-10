require 'rails_helper'

RSpec.describe Gym, :type => :model do
  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :phone }
    it{ should validate_presence_of :email }
  end

  describe 'Associations' do
    it{ should have_one :contact_info }
  end
end
