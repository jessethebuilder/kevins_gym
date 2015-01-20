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
  #
  #FEATURES = {
  #    :membership => '',
  #    :classes => ,
  #    :personal_training => ,
  #    :nutrition
  #}

  SOCIAL_NETWORKS = {:facebook => {:link => 'https://www.facebook.com/pages/Sequim-Gym/414083728647866'}
                     #:twitter => {:link => '#'},
                     #:youtube => {:link => '#'}
  }

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