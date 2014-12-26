class CreateNewsStories < ActiveRecord::Migration
  def change
    create_table :news_stories do |t|
      t.string :title
      t.text :content
      t.integer :author_id
      t.boolean :published, :default => false
      t.boolean :archived, :default => false

      t.timestamps
    end
  end
end
