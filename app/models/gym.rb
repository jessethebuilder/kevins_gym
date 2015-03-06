  class Gym < ActiveRecord::Base
  validates :name, :presence => true
  validates :phone, :presence => true
  validates :email, :presence => true

  # has_one :address, :as => 'has_address'
  has_one :contact_info, :as => :has_contact_info, :dependent => :destroy

  def address
    contact_info.address
  end
end
