module UserHelper

  def skills_list(user)
    html = '<ul class="skills_list">'
    user.skills.each do |s|
      html += '<li>'
      html += s.titlecase
      html += '</li>'
    end
    html += '</ul>'
    html.html_safe
  end

end
