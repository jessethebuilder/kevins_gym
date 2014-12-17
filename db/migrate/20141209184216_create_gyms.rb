class CreateGyms < ActiveRecord::Migration
  def change
    create_table :gyms do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :fax

      t.timestamps
    end
  end
end
