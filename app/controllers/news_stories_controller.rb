class NewsStoriesController < ApplicationController
  include SaveDraftArchiveDeleteControllerHelper

  before_action :set_news_story, only: [:show, :edit, :update, :destroy]
  before_action :set_upcoming_classes, :only => [:index]

  before_action :except => [:index, :show] do |controller|
    authenticate_user_level!(controller, :staff)
  end

  respond_to :html

  def index
    @news_stories = NewsStory.records(:order => 'updated_at DESC')
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

    publish_or_archive(@news_story)

    @news_story.save
    respond_with(@news_story)
  end

  def update
    publish_or_archive(@news_story)


    @news_story.update(news_story_params)
    respond_with(@news_story)
  end

  def destroy
    @news_story.destroy
    notice << "#{@news_story.title} has been destroyed forever"
    respond_with(@news_story)
  end

  private
    def set_news_story
      if p = params[:id]
        @news_story = NewsStory.find(p)
      else
        @news_story = NewsStory.new
      end
    end

    def news_story_params
      params.require(:news_story).permit(:title, :content, :author_id, :published, :archived,
                                         :bootsy_image_gallery_id,
                                         :main_image, :main_image_cache, :remote_main_image_url)
    end

    #def publish?
    #  params[:commit] == 'Publish'
    #end
    #
    #def archive?
    #  params[:commit] == 'Archive'
    #end
end
