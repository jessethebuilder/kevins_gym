module ApplicationHelper
  def quick_options(options)
    html = initiate_quick_options
    html += '<ul class="quick_options">'
    options.each do |o|
      html += '<li>'
        html += link_to o[0], o[1]
      html += '</li>'
    end
    html += '</ul>'
    html.html_safe
  end

  def initiate_quick_options
    "<script>quickOptionsBehaviors();</script>"
  end

end