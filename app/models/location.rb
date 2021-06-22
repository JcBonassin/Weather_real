class Location < ActiveRecord::Base
    validate :only_one
    belongs_to :user 
    validates_presence_of :weather_location, :user_id
    
    private

    def only_one
        if Location.count >= 300
            errors.add :base, 'error'
        end
    end
end 