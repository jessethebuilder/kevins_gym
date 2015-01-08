class AddSkillsToUser < ActiveRecord::Migration
  def change
    add_column :users, :skills, :text, :array => true, :default => []
  end
end
