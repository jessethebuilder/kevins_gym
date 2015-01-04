class Event < ActiveRecord::Base
  extend SimpleCalendar
  include Bootsy::Container

  before_validation do
    write_attribute(:ends_at, starts_at + @duration.minutes) if @duration
  end

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

  #----------------Custom Validations ------------------------------
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

  def month
    starts_at.strftime('%B')
  end

  def day_name
    starts_at.strftime('%A')
  end

  def date
    starts_at.strftime('%e/%m/%Y')
  end

  def start_time
    starts_at.strftime('%l:%M%P')
  end

  def day_of_event
    "#{day_name}, #{starts_at.strftime('%B %e')}"
  end

  def duration=(val)
    @duration = Integer(val)
    #write_attribute(:ends_at, starts_at + Integer(val).minutes);
  end

  def duration
    if ends_at && starts_at
      Integer((ends_at - starts_at) / 60)
    end
  end


  #Class Methods-------------------------
  scope :classes, -> { where(:event_type => 'class') }
  scope :after_now, ->{ where('starts_at >= ?', Time.now) }
  scope :soonest_first, -> { after_now.order(:starts_at) }

  def Event.events
    Event.all
  end

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
