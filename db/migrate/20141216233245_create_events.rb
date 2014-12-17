class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :name
      t.text :description
      t.string :reoccurs_every
      t.integer :user_id

      t.timestamps
    end
  end
end
