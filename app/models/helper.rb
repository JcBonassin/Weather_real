class Helper
    def self.lat
        results = Geocoder.search(ip)
        results.first.coordinates
        response = results.first.coordinates  
        lat = response[0]
    end 
     
    def self.lon
        results = Geocoder.search(ip)
        results.first.coordinates
        response = results.first.coordinates  
        lon = response[1]
    end  
    
    def self.ip
        url = URI("https://freegeoip.app/json/")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(url)   
        request["accept"] = 'application/json'
        request["content-type"] = 'application/json'
        response = http.request(request)
        data = JSON.parse(response.body, symbolize_names: true)
        ip = data.fetch(:ip)
    end 

end 

class Error < StandardError

    def message
        puts "Sorry location not found" 
    end
end
