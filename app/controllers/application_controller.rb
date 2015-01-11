class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    allowed_params = [:level, :avatar, :avatar_cache, :first_name, :last_name]
    devise_parameter_sanitizer.for(:sign_up) << allowed_params
    devise_parameter_sanitizer.for(:account_update) << allowed_params
  end

  def authenticate_user_level!(controller, min_level)
    if controller.send(:user_signed_in?)
      ul = controller.send(:current_user).level
      return if User::USER_LEVELS.index(ul) >= User::USER_LEVELS.index(min_level)
    end
    redirect_to root_path, :alert => 'Access Denied!'
  end

  def set_upcoming_classes(user: nil)
    @upcoming_classes = Event.upcoming_classes(:user => user) || {}
  end



end
