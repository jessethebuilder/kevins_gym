class AddMainImageToEvent < ActiveRecord::Migration
  def change
    add_column :events, :main_image, :string
  end
end
