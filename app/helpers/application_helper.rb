module ApplicationHelper
  include HtmlTools
  include SecurityGate

  def gym
    Gym.first || Gym.new
  end

  def quick_options(options)
    html = initiate_quick_options
    #html += '<div class="row pull-right">'
    #html += '<div class="col-lg-12 pull-right">'
    html += '<ul class="quick_options">'
    options.each do |o|
      html += '<li>'
        html += link_to o[0], o[1]
      html += '</li>'
    end
    html += '</ul>'
    #html +='</div>'
    #html += '</div>'
    html.html_safe
  end

  def initiate_quick_options
    "<script>$(document).ready(function(){
                      quickOptionsBehaviors();
              })</script>"
  end

  SOCIAL_NETWORKS = {:facebook => {:link => 'www.facebook.com'},
                     :twitter => {:link => '#'},
                     :youtube => {:link => '#'}
  }

  def social_networking_row(networks: SOCIAL_NETWORKS.keys.collect(&:to_s), icon_class: 'social_icon')
    html = ''
    networks.each do |nw|
      html += link_to image_tag("icons/social_networking/#{nw}_icon.png"), '#', :class => icon_class
    end
    html.html_safe
  end



end