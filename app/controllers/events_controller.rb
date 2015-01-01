class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :only => [:index]
  before_action :set_event_categories, :only => [:new, :create, :edit, :update]
  before_action :set_event_type, :only => [:new, :create, :edit, :update, :index]

  respond_to :html

  def index
    @calendar_view = current_calendar_view
    @partial_path = "/events/calendar/#{@calendar_view}"

    scoped_events = Event.send(@event_type.pluralize.to_sym)

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
    @event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash.notice = "#{@event.name} has been created."
    end
    respond_with(@event)
  end

  def update
    if @event.update(event_params)
      flash.notice = "#{@event.name} has been updated."
    end
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

    def set_event_type
      #event_type defaults to class
      if @event
        @event_type = @event.event_type
      else
        #index action relies on this to fall though until 'class' for new, create, etc. where the param isn't give
        #via URL.
        @event_type = params[:event_type] || 'class'
      end
    end

    def set_event_categories
      @event_categories = EventCategory.all
    end

    def event_params
      params.require(:event).permit(:start, :end, :name, :description, :reoccurs_every, :user_id, :duration,
                                    :event_type, :event_category_id, :starts_at, :ends_at,
                                    :bootsy_image_gallery_id,
                                    :main_image, :main_image_cache, :remote_main_image_url)
    end

    #calendar methods------------------------------------------
    def current_calendar_view
      #set the session and return
      session[:calendar_view] = params[:calendar_view] || session[:calendar_view] || 'week'
    end

    def calendar_start_date
      params[:start_date] || Date.today
    end
end
