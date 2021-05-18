class Locations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :weather_location
      t.integer :user_id
    end
  end
end
