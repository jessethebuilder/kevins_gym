module ApplicationHelper
  include HtmlTools
  include SecurityGate

  def gym
    Gym.first || Gym.new
  end

  def quick_options(options)
    html = initiate_quick_options
    #html += '<div class="row">'
    html += '<ul class="quick_options">'

    options << yield if block_given?
    options.each do |o|
      html += '<li>'
        html += link_to o[0], o[1]
      html += '</li>'
    end
    html += '</ul>'
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

  def image_select(form_builder, object, uploader, version: :thumb)
    render :partial => 'parts/image_select', :locals => {:f => form_builder, :object => object,
                                                         :uploader => uploader, :version => version}
  end

  def durations_for_select
    [['Half Hour', 30], ['1 Hour', 60], ['Hour and a Half', 90], ['2 hours', 120]]
  end

  def user_bio(user_record)
    render :partial => 'users/full_bio', :locals => {:user_record => user_record}
  end


end