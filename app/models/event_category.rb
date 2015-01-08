class EventCategory < ActiveRecord::Base
  include Bootsy::Container

  has_many :events

  validates :name, :presence => true, :uniqueness => true
end
