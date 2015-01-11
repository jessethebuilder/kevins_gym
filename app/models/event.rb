class Event < ActiveRecord::Base
  extend SimpleCalendar
  include Bootsy::Container

  before_validation do
    #this is the only callback that would pass all specs, but it's a bit dirty.
    #it needs to check that both duration and starts_at. Maybe refactor soon.
   write_attribute(:ends_at, starts_at + @duration.minutes) if @duration && starts_at
  end

  has_calendar

  belongs_to :user
  belongs_to :event_category

  mount_uploader :main_image, MainImageUploader

  EVENT_TYPES = %w|class appointment appointment_request|
  #REOCCURRENCE_TYPES = %w|week never every_other_week every_month_on_this_day every_month_on_this_date|
  REOCCURRENCE_TYPES = %w|week day never|

  validates :event_category_id, :presence => true
  validates :reoccurs_every, :presence => true, :inclusion => {:in => REOCCURRENCE_TYPES}
  validates :name, :presence => true
  validates :starts_at, :presence => true
  validates :event_type, :presence => true, :inclusion => {:in => symbols_and_strings(EVENT_TYPES)}

  #----------------Custom Validations ------------------------------
  validate :has_duration_if_class, :has_user_if_class #, :ends_at_is_after_starts_at

  def has_duration_if_class
    #errors.add :duration, 'cannot be blank' if duration.nil?
    errors.add :duration, 'cannot be blank' if event_type == 'class' && duration.nil?
  end

  def has_user_if_class
    errors.add :user_id, 'class must have an instructor' if event_type == 'class' && user_id.nil?
  end
  #
  #def ends_at_is_after_starts_at
  #  unless ends_at.nil?
  #    errors.add :ends_at, 'must be after start time' if ends_at < starts_at
  #  end
  #end

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
    "#{day_name}, #{starts_at.strftime('%B')}#{ActiveSupport::Inflector.ordinalize(starts_at.strftime('%e'))}"
  end

  def duration=(val)
    @duration = val ? Integer(val) : 0
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

  def Event.classes_by(user)
    classes.where(:user_id => user.id).soonest_first
  end

  def Event.events
    Event.all
  end

  def Event.upcoming_classes(day_count = 7, user: nil)
    #returns a hash with dates for keys and Arrays of Events (of type :class), ordered by date, soonest first
    if user
      classes = classes_by(user)
    else
      classes = self.classes.soonest_first
    end

    all_hash = classes.group_by{ |event| event.date}
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
