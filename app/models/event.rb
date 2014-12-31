class Event < ActiveRecord::Base
  extend SimpleCalendar
  include Bootsy::Container

  has_calendar

  belongs_to :user
  belongs_to :event_category

  mount_uploader :main_image, MainImageUploader

  EVENT_TYPES = [:class, :appointment, :appointment_request]
  REOCCURRENCE_TYPES = %w|never week every_other_week every_month_on_this_day every_month_on_this_date|

  validates :event_category_id, :presence => true
  validates :reoccurs_every, :presence => true, :inclusion => {:in => REOCCURRENCE_TYPES}
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

  def day_name
    starts_at.strftime('%A');
  end

  def date
    starts_at.strftime('%e/%m/%Y')
  end

  def start_time
    starts_at.strftime('%l:%M%P')
  end

  #Class Methods-------------------------
  scope :classes, where(:event_type => 'class')
  scope :soonest_first, order(:starts_at)

  def Event.upcoming_classes(day_count = 7)
    #returns a hash with dates for keys and Arrays of Events (of type :class), ordered by date, soonest first
    all_hash = classes.soonest_first.group_by{ |event| event.date }
    #limit the number of days

    h = {}
    i = 0
    all_hash.each do |k, v|
      if i < day_count
        h[k] = v
        i += 1
      else
        break
      end
    end
    h
  end


end
