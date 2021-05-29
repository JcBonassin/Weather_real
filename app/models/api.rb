class API < Helper
require 'uri'
    attr_accessor :location 

    def self.search_location(weather_location)
        results = Geocoder.search(weather_location)
        if  results === []
            begin
                raise Error
              rescue Error => e
                puts e.message
              end
              return
         end 
        response = results.first.coordinates  
        lat = response[0]
        lon = response[1]
        self.search(lat, lon)  
    end 
        
    
    def self.search(lat, lon)
        response = HTTParty.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&exclude=minutely&appid=#{ENV['API_KEY']}&units=metric")
        data = JSON.parse(response.body, symbolize_names: true)
    end 
    
    def self.auto_search
        lat = self.lat
        lon = self.lon
        self.search(lat, lon) 
    end 
    
    def self.location_name
        results = Geocoder.search(ip)
        results.first.city   
    end 

    def self.news
        response = HTTParty.get("https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=#{ENV['API_NEWS']}")
        data = JSON.parse(response.read_body, symbolize_names: true)
    end 

  def self.photo(location)
    response = HTTParty.get("https://api.unsplash.com/search/photos?query=#{location}&client_id=#{ENV['API_Photos']}")
    data = JSON.parse(response.read_body, symbolize_names: true) 
    end 

    def self.location_photo
        results = Geocoder.search(ip)
        location = results.first.city 
        self.photo(location)    
    end 

    def self.search_location_photo(weather_location)
        results = Geocoder.search(weather_location)
        if  results === []
            begin
                raise Error
              rescue Error => e
                puts e.message
              end
              return
         end 
        location = results.first.city
        self.photo(location)  
    end 

    #def self.auto_url(server, id, secret)
    #    server = self.server
    #    id = self.id
    #    secret = self.secret
    #    self.url(lat, lon) 
    #end 

 end 
    
   
    