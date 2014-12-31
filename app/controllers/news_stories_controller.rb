class NewsStoriesController < ApplicationController
  before_action :set_news_story, only: [:show, :edit, :update, :destroy]
  before_action :set_upcoming_classes, :only => [:index]


  #before_filter authenticate_user_level!(:staff), :only => [:new, :create, :edit, :update, :destroy]

  before_action :except => [:index, :show] do |controller|
    authenticate_user_level!(controller, :staff)
  end

  respond_to :html

  def index
    @news_stories = NewsStory.records
    respond_with(@news_stories)
  end

  def show
    respond_with(@news_story)
  end

  def new
    @news_story = NewsStory.new
    respond_with(@news_story)
  end

  def edit
  end

  def create
    @news_story = NewsStory.new(news_story_params)
    @news_story.published = publish?
    @news_story.archived = archive?

    @news_story.save
    respond_with(@news_story)
  end

  def update
    @news_story.published = publish?
    @news_story.archived = archive?

    @news_story.update(news_story_params)
    @news_story.save
    respond_with(@news_story)
  end

  def destroy
    @news_story.destroy
    respond_with(@news_story)
  end

  private
    def set_news_story
      @news_story = NewsStory.find(params[:id])
    end

    def news_story_params
      params.require(:news_story).permit(:title, :content, :author_id, :published, :archived,
                                         :bootsy_image_gallery_id,
                                         :main_image, :main_image_cache, :remote_main_image_url)
    end

    def publish?
      params[:commit] == 'Publish'
    end

    def archive?
      params[:commit] == 'Archive'
    end

    def set_published_or_archived

    end
end
