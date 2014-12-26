class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events
  has_many :news_stories, :foreign_key => :author_id

  USER_LEVELS = [:member, :staff, :admin, :owner]
  AFFILIATED_LEVELS = [:staff, :admin, :owner]

  #validates :level, :presence => true

  validate :staff_or_higher_has_names, :user_level_is_in_list

  def user_level_is_in_list
    l = read_attribute(:level)
    errors.add(:level, 'is not included in the list') unless symbols_and_strings(USER_LEVELS).include?(l)
    errors.add(:level, 'cannot be blank') unless l
  end

  def staff_or_higher_has_names
    if level_is_at_least :staff
      errors.add(:first_name, 'cannot be blank') if first_name.blank?
      errors.add(:last_name, 'cannot be blank') if last_name.blank?
    end
  end

  def level_is_at_least(level)
    raise ArgumentError, "#{level} is not a valid User level" unless symbols_and_strings(USER_LEVELS).include?(level.to_sym)
    #self.level && USER_LEVELS.index(self.level.to_sym) >= USER_LEVELS.index(level.to_sym)
    self.level.level && self.level >= level
  end

  def name
    #todo test
    names = [first_name.to_s, last_name.to_s].join(' ')
    names.length > 1 ? names : 'anonymous'
  end

  def level
    UserLevel.new(read_attribute(:level))
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  mount_uploader :avatar, AvatarUploader

  #Class Methods
  def User.affiliated
    User.where.not(:level => 'member')
  end


end

class UserLevel
  include Comparable
  L = User::USER_LEVELS.dup.insert(0, :nonuser)

  attr_accessor :level

  def initialize(level)
    @level = level.to_sym unless level.nil?
  end

  def <=>(other)
    L.index(self.level) <=> L.index(other.to_sym)
  end

  def to_s
    @level.to_s
  end

  def to_sym
    @level
  end

end