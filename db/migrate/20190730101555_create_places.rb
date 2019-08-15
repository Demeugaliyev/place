class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.text :description
      t.text :short_description
      t.string :picture_url
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.timestamps null: false
    end
  end
end
