  class Gym < ActiveRecord::Base
  validates :name, :presence => true
  validates :phone, :presence => true
  validates :email, :presence => true

  has_one :address, :as => 'has_address'
end
