class Event < ActiveRecord::Base
  extend SimpleCalendar
  include Bootsy::Container

  before_validation do
    #this is the only callback that would pass all specs, but it's a bit dirty.
    #it needs to check that both duration and starts_at. Maybe refactor soon.
   write_attribute(:ends_at, starts_at + @duration.minutes) if @duration && starts_at
  end
  validates :duration, :presence => true, :numericality => {:only_integer => true}

  has_calendar

  belongs_to :user
  belongs_to :event_category

  mount_uploader :main_image, MainImageUploader

  EVENT_TYPES = %w|class appointment appointment_request|
  #REOCCURRENCE_TYPES = %w|week never every_other_week every_month_on_this_day every_month_on_this_date|
  REOCCURRENCE_TYPES = %w|week day never|

  #validates :event_category_id, :presence => true
  validates :reoccurs_every, :presence => true, :inclusion => {:in => REOCCURRENCE_TYPES}
  validates :name, :presence => true
  validates :starts_at, :presence => true
  validates :event_type, :presence => true, :inclusion => {:in => EVENT_TYPES}

  #----------------Custom Validations ------------------------------
  validate :has_user_if_class

  def has_user_if_class
    errors.add :user_id, 'class must have an instructor' if event_type == 'class' && user_id.nil?
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
    "#{day_name}, #{starts_at.strftime('%B')}#{ActiveSupport::Inflector.ordinalize(starts_at.strftime('%e'))}"
  end

  def duration=(val)
    @duration = val ? Integer(val) : nil
  end

  def duration
    #ends_at is set in before_validation filter, because it needs to be set before record is saved,
    #after the duration value is set (here).
    if ends_at && starts_at
      Integer((ends_at - starts_at) / 60)
    else
      nil
    end
  end

  def reoccurs?
    reoccurs_every == 'never' ? false : true
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

    group_records(classes, :date, :count => day_count)
  end

  def self.reoccuring
    where.not(:reoccurs_every => 'never')
  end

  def self.reoccurences(from = Time.now, to = Time.now + 1.month)
    ret = []
    reoccuring.each do |r|
      ret << build_reoccurances(r, from, to)
    end
    ret.flatten
  end

  private


  def self.build_reoccurances(record, from, to)
  #todo make sure this works if the origional record falls within to - from
    ret = []
    starting_time_difference = from - record.starts_at
    time = from + starting_time_difference
    until time > to do
      new_record = record.dup
      new_record.starts_at = time
      ret << new_record
      time += 1.send(record.reoccurs_every.to_sym)
    end
    ret
  end


end
