module EventsHelper
  include CalendarsHelper

  def event_time_in_words(event)
    #todo spec
    case event.reoccurs_every
      when 'never'
        "#{event.day_of_event} at#{event.start_time}"
      when 'week'
        "Every #{event.day_name}"
      when 'day'
        "Every day at#{event.start_time}"
      #when 'every_other_week'
      #  "Every other week on #{event.day_name}"
      #when 'every_month_on_this_day'
      #  day_position_in_month = (Integer(event.starts_at.strftime('%d')) / 7) + 1
      #  "#{ActiveSupport::Inflector.ordinalize(day_position_in_month)} #{event.day_name} of every month"
      #when 'every_month_on_this_date'
      #  "Every month on the #{ActiveSupport::Inflector.ordinalize(event.starts_at.strftime('%d'))}"
    end
  end


end
