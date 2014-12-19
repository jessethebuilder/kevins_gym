module ApplicationHelper
  def calendar_week_time_slots(start_time, end_time, increment_in_minutes)
    time = Time.new(start_time)
    html = ''
    while time <= Time.new(end_time) do
    #100.times do
      html += content_tag(:div, :id => "time_slot-#{time.to_s}", :class => 'calendar_week_time_slot') do
        content_tag(:span, :class => 'pull-left') do
          time.strftime('%l:%M %P')
        end
      end

      time = time + increment_in_minutes.minutes
    end
    html.html_safe
  end

  def calendar_start_time
    '7:00a'
  end

  def calendar_end_time
    '7:00p'
  end
end
