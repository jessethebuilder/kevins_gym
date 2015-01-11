require 'rails_helper'

RSpec.describe EventCategory, :type => :model do
  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_uniqueness_of :name }
  end

  describe 'Associations' do
    it{ should have_many :events }
  end
end
