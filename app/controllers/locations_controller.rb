class LocationsController < ApplicationController

    get '/main' do
        if logged_in?
          @weather = API.auto_search
          @location = API.location_name
          @news = API.news 
          @news_weather = API.news_weather
          @locations = current_user.locations.all
          @photos = API.location_photo
          
          erb :'locations/main'
        else
          redirect to '/'
        end
      end
      
      post '/main' do 
            weather_location = params[:weather_location]
            @weather = API.search_location(weather_location)
            @location = params[:weather_location]
            @photos = API.search_location_photo(weather_location)
            @news = API.news
            if !params[:weather_location].empty?  
              @user = current_user
              @locations = Location.create(weather_location:params[:weather_location], user_id:@user.id)
                 if (@weather == nil && @photos == nil || @photos == {:total=>0, :total_pages=>0, :results=>[]})
                   flash[:errors] = "Location Error. Please try to add a valid location again"
                    @locations.destroy
                    redirect_to_main
                  elsif Location.count >= 300 
                    flash[:errors] = "Sorry. You can only add a Max of 4 locations. Please update or delete one of them"
                    @locations.destroy
                    redirect_to_main
                 else
                   flash[:message] = "Your location Has Been Succesfully added. Please click on the location link for more info"
                   @locations.save     
                   redirect_to_main
                 end 
              else 
              flash[:errors] = "Please don't leave blank content"                
              redirect_to_main
              end 
      end 

     

      get '/main/:id' do
        if logged_in?
           
            @locations = Location.find_by_id(params[:id])
            @weather1 = API.search_location(@locations.weather_location)
            @news = API.news  
          erb :'locations/show'
        else
          redirect to '/'
        end 
      end

      patch '/main/:id' do
        if !params[:weather_location].empty? 
          @locations = Location.find(params[:id])
          @locations.update(weather_location:params[:weather_location])
          @weather = API.search_location(@locations.weather_location)
            if (@weather == nil && @photos == nil)
              flash[:errors] = "Internal Location Error. Stop hacking!!. Sorry Your entry has been deleted. Please try to add a valid location again"
               @locations.destroy
               redirect_to_main
            else
              @locations.save
              flash[:message] = "Your location Has Been Succesfully Updated"
              redirect to "/main/#{params[:id]}"
            end 

        else
          flash[:message] = "Please Don't Leave Blank Content"
          redirect to "/main/#{params[:id]}"
        end
      end


      get '/photos' do
        @photos = API.location_photo
        @location = API.location_name
          if logged_in?
            erb :'locations/photos_location'
          else
            redirect to '/login'
          end
        end


      delete '/main/:id/delete' do
        if logged_in?
             @locations = Location.find_by_id(params[:id])
            @weather = API.search_location(params[:id])
            @news = API.news  
           @locations && @locations.user == current_user
            flash[:message] = "Your location has been deleted successfully"
            @locations.destroy
          
          redirect to '/main'
        else
          redirect to '/login'
        end
      end
end 