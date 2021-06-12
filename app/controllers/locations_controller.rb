class LocationsController < ApplicationController

    get '/main' do
        if logged_in?
          @weather = API.auto_search
          @location = API.location_name
          @news = API.news 
          @locations = current_user.locations.all
          @photos = API.location_photo
          
          erb :'locations/main'
        else
          redirect to '/'
        end
      end

      #get '/main/new' do
      #  if logged_in?
      #    erb :'locations/add_location'
      #  else
      #    redirect to '/login'
      #  end
      #end
      
      post '/main' do 
            weather_location = params[:weather_location]
            @weather = API.search_location(weather_location)
            @location = params[:weather_location]
            #@location2 = API.search_location(@location)
            @photos = API.search_location_photo(weather_location)
            #@photosf = API.search_location_photo_flickr(weather_location)
            @news = API.news
             # if @weather == nil
             #   flash[:message] = "Location Error. Please try again"
             # end 
            if !params[:weather_location].empty?  
              @user = current_user
              @locations = Location.create(weather_location:params[:weather_location], user_id:@user.id)
                 if (@weather == nil && @photos == nil || @photos == {:total=>0, :total_pages=>0, :results=>[]})
                   flash[:errors] = "Location Error. Please try to add a valid location again"
                    @locations.destroy
                    redirect_to_main
                  elsif Location.count >= 200 
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
              
             # flash[:message] = "YAY.. Success, Your locations has been succesfully added "
             # @locations.save
#
             #      flash[:errors] = "Please don't leave blank content"
             #      redirect to "/main"
             #         if (@weather == nil && @photos == nil)
             #          flash[:errors] = "Location Error. Your entry has been deleted. Please try to add that location again"
             #           @locations.destroy
             #           redirect_to_main
             #         else 
             #          redirect_to_main
             #         end
             #    #end 
             #    #if @weather == nil
             #    # flash[:message] = "Location Error. Please try again"
             #    # redirect_to_main
             #else
             #  @user = current_user
             #  @locations = Location.create(weather_location:params[:weather_location], user_id:@user.id)
             #  flash[:message] = "YAY.. Success, Your locations has been succesfully added "
             #  @locations.save
             # #@locations = @user.locations.find_or_create_by(weather_location:params[:weather_location])
             # #@locations = current_user.locations.build(weather_location:params[:weather_location])
             # #redirect to "/main/#{@locations.id}"
             # #@locations.save
             # redirect_to_main
            #end 
            #erb :'locations/main'
            #    if params[:weather_location] == ""
            #      redirect to "/main"
            #    else
            #      @locations = current_user.locations.build(weather_location: params[:weather_location])
            #        if @locations.save
            #        redirect to "/main"
            #        #redirect to "/main/#{@locations.id}" only to re-direct for rhe submit box
            #        else
            #        redirect to "/main/new"
            #      end 
            #    end
           
              #erb :'locations/main'
              #redirect to '/login'
              #redirect_to_main
         #end
      end 

     # post '/main/update' do 
     #   weather_location = params[:weather_location]
     #   @weather = API.search_location(weather_location)
     #   @location = params[:weather_location]
     #   @news = API.news
     #   @locations = current_user.locations.all 
     #   erb :'locations/main'
     #   end

      get '/main/:id' do
        if logged_in?
            #weather_location = params[:weather_location]
            @locations = Location.find_by_id(params[:id])
            @weather1 = API.search_location(@locations.weather_location)
            #@photos = API.search_location_photo(@locations.weather_location)
            # @weather = API.search_location(params[:id])
            @news = API.news  
            #if (@weather == nil && @photos == nil)
            #  flash[:message] = "Location Error. Your entry has been deleted. Please try to add that location again"
            #  #redirect to "/main/#{params[:id]}/edit"
            #  @locations.destroy
            #  redirect_to_main
            #end
            #@weather = API.search_location(params[:id])
            #@user = User.find(params[:id])
            # end 
          erb :'locations/show'
        else
          redirect to '/'
        end 
      end

 #     get '/main/all' do
 #       
 #       @locations = Location.find_by_id(params[:id])
 #       @weather = API.search_location(params[:id])
 #       @news = API.news 
 #       #@user = User.find(params[:id])
 #     erb :'locations/'
 #   
 # end

    #  get '/main/:id/edit' do
    #   # if logged_in?
    #      @locations = Location.find_by_id(params[:id])
    #      @weather = API.search_location(@locations.weather_location)
    #      @news = API.news 
    #      if @weather == nil
    #        flash[:message] = "Location Error. Please try again"
    #        redirect to "/main/#{@locations.id}"
    #      else 
    #     # if @locations && @locations.user == current_user
    #     #   erb :'locations/show'
    #     # else
    #     #   redirect to '/main'
    #     # end
    #    #else
    #    #  redirect to '/login'
    #    #end
    #    erb :'locations/edit_location'
    #      end
    #  end

      patch '/main/:id' do
        if !params[:weather_location].empty? 
          @locations = Location.find(params[:id])
          @locations.update(weather_location:params[:weather_location])
          @weather = API.search_location(@locations.weather_location)
          # @photos = API.search_location_photo(@locations.weather_location)
            if (@weather == nil && @photos == nil)
              flash[:errors] = "Internal Location Error. Stop hacking!!. Sorry Your entry has been deleted. Please try to add a valid location again"
               @locations.destroy
               redirect_to_main
            else
              @locations.save
              flash[:message] = "Your location Has Been Succesfully Updated"
              redirect to "/main/#{params[:id]}"
            end 

       # if @weather == nil
       #   flash[:message] = "Location Error. Please try again"
       #   redirect to "/main/#{@locations.id}"
        else
          flash[:message] = "Please Don't Leave Blank Content"
          redirect to "/main/#{params[:id]}"
        end
      end


      get '/photos' do
        @photos = API.location_photo
        @photosf = API.auto_location_photo_flickr
          if logged_in?
            erb :photos
          else
            redirect to '/login'
          end
        end

     # patch '/main/:id' do
     #   #if logged_in?
     #     if params[:weather_location].empty?
     #       flash[:message] = "Please don't leave blank content"
     #       #redirect to "/main/#{params[:id]}/edit"
     #       redirect to "/main/#{@locations.id}"
     #     end 
     #     if @weather == nil
     #       flash[:message] = "Location Error. Please try again"
     #       #redirect to "/main/#{params[:id]}/edit"
     #       redirect to "/main/#{@locations.id}"
     #     end 
#
     #     #if params[:weather_location] == ""
     #     #  flash[:error] = "Location Error"
     #     #  #redirect to "/main/#{params[:id]}/edit"
     #     #  redirect to "/main/#{@locations.id}"
     #     #else
     #       @locations = Location.find_by_id(params[:id])
     #      # @weather = API.search_location(@locations.weather_location)
     #       if @locations && @locations.user == current_user
     #          @locations.update(weather_location: params[:weather_location])
     #           flash[:message] = "Location Updated"
     #           redirect to "/main/#{@locations.id}"
     #          # if @weather == nil
     #          #   flash[:message] = "Location Error. Please try again"
     #          #   redirect to "/main/#{@locations.id}/edit"
     #           end
     #         #else
     #         #  #redirect to "/main/#{@locations.id}/edit"
     #         #  redirect to "/main/#{@locations.id}"
     #         #end
     #       #else
     #       #  redirect to '/main'
     #       #end
     #     #end
     #   #else
     #   #  redirect to '/login'
     #   #end
     # end
#

      delete '/main/:id/delete' do
        if logged_in?
             @locations = Location.find_by_id(params[:id])
            #@weather = API.search_location(@locations.weather_location)
            @weather = API.search_location(params[:id])
            @news = API.news  
            #if @weather == nil
            #  flash[:message] = "Location Error. Please try again"
            #  redirect_to_main
            #else 
           @locations && @locations.user == current_user
            flash[:message] = "Your location has been deleted successfully"
            @locations.destroy
          
          redirect to '/main'
        else
          redirect to '/login'
        end
      end

     # delete '/main/delete' do
     #   if logged_in?
     #     @locations = Location.all
     #     @locations.destroy
     #     #@locations.update
     #     redirect_to_main
        #end 
        #  #@locations = Location.find_by_id(params[:id])
        #  if @locations && @locations.user == current_user
        #    @locations.all_delete
        #    @locations.update
        #  end
        #  redirect to '/main'
     #   else
     #     redirect to '/login'
     #   end
     # end

   #   patch '/main/delete' do
   #     if logged_in?
   #         @locations = current_user.locations.all.destroy
   #         #@locations.update
   #         #redirect_to_main
   #     else
   #       redirect to '/login'
   #     end
   #   end
end 