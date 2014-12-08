class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :title
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.text :bio

      t.timestamps
    end
  end
end
