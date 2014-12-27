module CalendarsHelper
  def number_of_days_on_week_calendar
    7
  end

  def calendar_start_time
    '7:00am'
  end

  def calendar_end_time
    '7:00pm'
  end

  def calendar_increment_in_minutes
    30
  end

  def round_to_nearest_increment(date, increment = calendar_increment_in_minutes)
    rounded_minutes = ((Float(date.min) / increment).round * increment).to_s
    rounded_minutes = '0' + rounded_minutes if rounded_minutes.length == 1
    if rounded_minutes == '60'
      rounded_minutes = '00'
      date = date + 1.hour
    end
    "#{date.strftime('%I')}:#{rounded_minutes}#{date.strftime('%P')}"
  end


  def round_and_format(datetime, strftime_string = '%I:%M%P', increment = calendar_increment_in_minutes)
    time = round_to_nearest_increment(datetime, increment)
    time = Time.parse(time).strftime(strftime_string) unless strftime_string == '%I:%M%P'
    time
  end

  #specific use methods
  def calendar_day_time_slots(start_time, end_time, increment_in_minutes)
    time = Time.parse(start_time)
    html = ''
    while time <= Time.parse(end_time) do
      html += content_tag(:div, 'data-time_slot' => time.strftime('%I:%M%P'), :class => 'calendar_day_time_slot') do
        content_tag(:span, :class => 'pull-left') do
          time.strftime('%l:%M %P')
        end
      end

      time = time + increment_in_minutes.minutes
    end
    html.html_safe
  end

  def week_collapse_control(date, open_or_close = 'open')
    up_down = open_or_close == 'open' ? 'down' : 'up'
    html = content_tag :a, :href => "javascript:collapseDayOnWeek('#week_calendar_#{date.strftime('%A')}', '#{open_or_close}')",
                       :class => "week_collapse_control week_collapse_#{open_or_close}" do
            %Q|<span class="glyphicon glyphicon-collapse-#{up_down} pull-right"></span>|.html_safe
    end
    html.html_safe
  end


end