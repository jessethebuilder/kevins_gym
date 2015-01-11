module ApplicationHelper
  include HtmlTools
  include Parts
  include SecurityGate

  def user_is_admin?
    user_signed_in? && current_user.level == 'admin'
  end

  def gym
    Gym.first || Gym.new
  end

  #def quick_options(options)
  #  html = initiate_quick_options
  #  #html += '<div class="row">'
  #  html += '<ul class="quick_options">'
  #
  #  options << yield if block_given?
  #  options.each do |o|
  #    html += '<li>'
  #      html += link_to o[0], o[1]
  #    html += '</li>'
  #  end
  #  html += '</ul>'
  #  #html += '</div>'
  #
  #  html.html_safe
  #end
  #
  #def initiate_quick_options
  #  "<script>$(document).ready(function(){
  #                    quickOptionsBehaviors();
  #            })</script>"
  #end

  SOCIAL_NETWORKS = {:facebook => {:link => 'www.facebook.com'},
                     :twitter => {:link => '#'},
                     :youtube => {:link => '#'}
  }

  #
  #def image_select(form_builder, object, uploader, version: :thumb)
  #  render :partial => 'parts/image_select', :locals => {:f => form_builder, :object => object,
  #                                                       :uploader => uploader, :version => version}
  #end

  def durations_for_select
    [['Half Hour', 30], ['1 Hour', 60], ['Hour and a Half', 90], ['2 hours', 120]]
  end

  def user_bio(user_record)
    render :partial => 'users/full_bio', :locals => {:user_record => user_record}
  end

  #---------------------Social Networking ------------------------------
  def facebook_comments_row(width: 550)
    html = '<div class="row">
              <div class="col-sm-12">
                <div class="facebook_comments text-center">'
    html += facebook_comments(request.url, :width => width)
    html +=    '</div>
             </div>
          </div>'
    html.html_safe
  end

  def social_networking_row(networks: SOCIAL_NETWORKS.keys.collect(&:to_s), icon_class: 'social_icon')
    html = ''
    networks.each do |nw|
      html += link_to image_tag("icons/social_networking/#{nw}_icon.png"), '#', :class => icon_class
    end
    html.html_safe
  end

  def social_networking_likes(tweet)
    render :partial => 'parts/social_networking_likes', :locals => {:tweet => tweet}
  end


end