class NewsStoriesController < ApplicationController
  before_action :set_news_story, only: [:show, :edit, :update, :destroy]
  before_action :set_upcoming_classes, only: [:index]

  respond_to :html, :js

  def index
    @news_stories = NewsStory.published.order('updated_at DESC')
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
    @news_story.save

    #this is the only change in the controller required for SaveDraftArchiveDelete (here and :update)
    #todo move this and #parse_commit to an extend maybe
    @news_story.commit = parse_commit


    # @news_story.save


    respond_with(@news_story)
  end

  def update

    @news_story.update(news_story_params)
    @news_story.commit = parse_commit

    respond_with(@news_story)
  end

  def destroy
    @news_story.destroy
    notice << "#{@news_story.title} has been destroyed forever"
    respond_with(@news_story)
  end

  private
  def set_news_story
    # if p = params[:id]
    @news_story = NewsStory.find(params[:id])
    # else
    #   @news_story = NewsStory.new
    # end
  end

  def parse_commit
    case params[:commit]
      when 'Save Draft'
        :draft
      when 'Publish'
        :publish
      when 'Archive'
        :archive
    end
  end

  def news_story_params
    params.require(:news_story).permit(:title, :content,
                                       :bootsy_image_gallery_id,
                                       :main_news_story_image, :main_news_story_image_cache, :remote_main_news_story_image_url)
  end
end