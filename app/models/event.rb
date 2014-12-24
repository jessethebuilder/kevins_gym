class Event < ActiveRecord::Base
  extend SimpleCalendar
  has_calendar

  belongs_to :user

  EVENT_TYPES = [:class, :appointment, :appointment_request]

  validates :name, :presence => true

  validates :starts_at, :presence => true

  validates :event_type, :presence => true, :inclusion => {:in => symbols_and_strings(EVENT_TYPES)}

  validate :has_ends_at_if_class, :has_user_if_class, :ends_at_is_after_starts_at

  def has_ends_at_if_class
    errors.add :ends_at, 'classes must have end time' if event_type == :class && ends_at.nil?
  end

  def has_user_if_class
    errors.add :user_id, 'class must have an instructor' if event_type == :class && user_id.nil?
  end

  def ends_at_is_after_starts_at
    unless ends_at.nil?
      errors.add :ends_at, 'must be after start time' if ends_at < starts_at
    end
  end


end
