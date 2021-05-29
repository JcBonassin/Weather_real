class Location < ActiveRecord::Base
    belongs_to :user 
    validates_presence_of :weather_location, :user_id
end 