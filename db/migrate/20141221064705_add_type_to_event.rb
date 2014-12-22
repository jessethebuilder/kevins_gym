class AddTypeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :event_type, :string
    #add_column :events, :type, :string
  end
end
