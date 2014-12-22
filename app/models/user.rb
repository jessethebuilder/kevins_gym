class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  USER_LEVELS = symbols_and_strings([:member, :staff, :admin, :owner])

  validates :level, :presence => true, :inclusion => {:in => USER_LEVELS}

  def level_is_at_least(level)
    raise ArgumentError, "#{level} is not a valid User level" unless USER_LEVELS.include?(level.to_sym)
    USER_LEVELS.index(self.level.to_sym) >= USER_LEVELS.index(level.to_sym)
  end



end
