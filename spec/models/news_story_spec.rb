require 'rails_helper'

RSpec.describe NewsStory, :type => :model do
  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :author_id }
  end

  describe 'Associations' do
    it{ should belong_to(:author).class_name('User') }
  end
end
