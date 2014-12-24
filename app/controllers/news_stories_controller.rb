class NewsStoriesController < ApplicationController
  before_action :set_news_story, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @news_stories = NewsStory.all
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
    respond_with(@news_story)
  end

  def update
    @news_story.update(news_story_params)
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
      params.require(:news_story).permit(:title, :content, :author_id, :published, :archived)
    end
end
