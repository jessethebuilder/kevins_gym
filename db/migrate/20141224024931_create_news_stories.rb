class CreateNewsStories < ActiveRecord::Migration
  def change
    create_table :news_stories do |t|
      t.string :title
      t.text :content
      t.integer :author_id
      t.boolean :published
      t.boolean :archived

      t.timestamps
    end
  end
end
