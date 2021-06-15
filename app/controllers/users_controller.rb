class UsersController < ApplicationController

  get '/signup' do
    @weather = API.auto_search
    @location = API.location_name
    @photos = API.location_photo
    @news = API.news
    @news_weather = API.news_weather
    if !logged_in?
      erb :index, :layout => :'/users/create_user'
    else
      redirect_to_main
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:name] == "" || params[:surname] == "" || params[:email] == "" || params[:password] == "" 
      flash[:errors] = "Please complete all details requested."
      redirect to '/signup' 
    else
      @user = User.new(:username => params[:username], :name => params[:name], :surname => params[:surname], :email => params[:email], :password => params[:password])
      flash[:message] = "You have successfully signed up in to Weather Be."
      @user.save
      session[:user_id] = @user.id
      redirect_to_main
    end
  end

    get '/login' do
        @weather = API.auto_search
        @location = API.location_name
        @photos = API.location_photo
        @news = API.news 
        @news_weather = API.news_weather
        if !logged_in?
          erb :index, :layout => :'users/login'
        else 
          redirect_to_main
        end
      end

      post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
          flash[:message] = "You Have Successfully Logged in to Weather Be."
          session[:user_id] = user.id
          redirect_to_main
        else
          flash[:errors] = "Account not found. Please Signup"
          redirect to '/signup'
        end
      end

      #get '/user/:slug' do
      #  @user = User.find_by_slug(params[:slug])
      #  erb :'users/edit_user'
      #end 

      get '/user/:id/edit' do
        if logged_in?
          erb :'users/show_details'
        else
          redirect to '/'
        end
      end

     patch '/user/:id' do
      if !(params[:username].empty? || params[:name].empty? || params[:surname].empty? || params[:password].empty?)
        @user = User.find(params[:id])
        @user.update(username:params[:username], name:params[:name], surname:params[:surname], password:params[:password])
        @user.save
        flash[:message] = "Account Updated"
        redirect to "/user/#{@user.id}"
      else
        flash[:errors] = "Please dont leave any empty field"
        redirect to "/user/#{params[:id]}"
      end
    end

      get '/user/:id' do
        #@weather = API.auto_search
        #@location = API.location_name
        #@news = API.news
        #@photos = API.location_photo
        if logged_in?
          erb :'users/show_details'
        else
          redirect to '/'
        end
      end


        delete '/user/:id/delete' do
          if logged_in?
            current_user.delete
            flash[:errors] = "Your account has been deleted. Good Luck!!!"
            redirect to "/logout"
          else
            redirect to '/'
          end
        
      end

      get '/logout' do
        if logged_in?
          session.clear
          redirect "/"
        end 
          redirect to '/'
      end  
end
