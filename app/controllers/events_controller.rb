class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :only => [:index]
  before_action :set_event_categories, :only => [:new, :edit]

  before_action :set_new_event, :only => [:new]
  before_action :set_event_type, :only => [:new, :edit]

  respond_to :html

  #def set_upcoming_classes
  #  #Event.recent returns a hash with dates for keys and an array of event for
  #  @upcoming_classes = Event.upcoming_classes || {}
  #end


  def index
    @calendar_view = current_calendar_view
    @calendar_scope = current_calendar_scope

    scoped_events = Event.send(@calendar_scope.to_sym)

    if @user
      @events = scoped_events.where(:user_id => @user.id)
    else
      @events = scoped_events
    end

    respond_with(@events)
  end

  def show
    respond_with(@event)
  end

  def new
    #@event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.save
    respond_with(@event)
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id]) if params[:user_id]
    end

    def set_new_event
      @event = Event.new
    end
    def set_event_type
      #event_type defaults to class
      @event_type = @event.event_type || params[:event_type] || 'class'
    end

    def set_event_categories
      @event_categories = EventCategory.all
    end

    def event_params
      params.require(:event).permit(:start, :end, :name, :description, :reoccurs_every, :user_id,
                                    :bootsy_image_gallery_id,
                                    :main_image, :main_image_cache, :remote_main_image_url)
    end

    #calendar methods------------------------------------------
    def current_calendar_view
      #set the session and return
      session[:calendar_view] = params[:calendar_view] || session[:calendar_view] || 'week'
    end

    def current_calendar_scope
      #classes is a temporary default, until we implement appointments
      sanatize_calendar_scope(params[:calendar_scope] || 'classes')
      #session[:calendar_scope] = sanatize_calendar_scope(params[:calendar_scope] || session[:calendar_scope] || 'classes')
    end

    def sanatize_calendar_scope(scope)
      allowed_scopes = %w|classes|
      allowed_scopes.include?(scope) ? scope : nil
    end

    def calendar_start_date
      params[:start_date] || Date.today
    end
end
