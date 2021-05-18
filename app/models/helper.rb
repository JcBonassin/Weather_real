class Helper
    def self.lat
        response = HTTParty.get("https://freegeoip.app/json/")
        ip = JSON.parse(response.body)
        lat = ip["latitude"]
    end 
     
    def self.lon
        response = HTTParty.get("https://freegeoip.app/json/")
        ip = JSON.parse(response.body)
        lon = ip["longitude"]
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
