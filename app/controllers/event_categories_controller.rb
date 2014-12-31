class EventCategoriesController < ApplicationController
  before_action :set_event_category, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @event_categories = EventCategory.all
    respond_with(@event_categories)
  end

  def show
    respond_with(@event_category)
  end

  def new
    @event_category = EventCategory.new
    respond_with(@event_category)
  end

  def edit
  end

  def create
    @event_category = EventCategory.new(event_category_params)
    @event_category.save
    respond_with(@event_category)
  end

  def update
    @event_category.update(event_category_params)
    respond_with(@event_category)
  end

  def destroy
    @event_category.destroy
    respond_with(@event_category)
  end

  private
    def set_event_category
      @event_category = EventCategory.find(params[:id])
    end

    def event_category_params
      params.require(:event_category).permit(:name, :description)
    end
end
