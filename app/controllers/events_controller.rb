class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @calendar_view = current_calendar_view
    @events = Event.all
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

    def event_params
      params.require(:event).permit(:start, :end, :name, :description, :reoccurs_every, :user_id)
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
