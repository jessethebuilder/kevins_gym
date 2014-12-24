class AddMainImageToNewsStory < ActiveRecord::Migration
  def change
    add_column :news_stories, :main_image, :string
  end
end
