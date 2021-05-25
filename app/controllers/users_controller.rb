class UsersController < ApplicationController

  get '/signup' do
    @weather = API.auto_search
    @location = API.location_name
    @news = API.news
    if !logged_in?
      erb :index, :layout => :'/users/create_user'
    else
      redirect_to_main
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup' # Add flash message
    else
      @user = User.new(:username => params[:username], :name => params[:name], :surname => params[:surname], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      flash[:success] = "You have succesfully signup."
      redirect_to_main
    end
  end

    get '/login' do
      if !logged_in?
        @weather = API.auto_search
        @location = API.location_name
        @news = API.news 
        erb :index, :layout => :'users/login'
        else 
          redirect_to_main
        end
      end

      post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to_main
        else
          flash[:message] = "Account not found"
          redirect to '/signup'
        end
      end

      get '/user/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/edit_user'
      end 

      get '/user/:id/edit' do
        if logged_in?
          erb :'users/edit_user'
        else
          redirect to '/'
        end
      end

     patch '/user/:id' do
      if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
        @user = User.find(params[:id])
        @user.update(username:params[:username], email:params[:email], password:params[:password])
        flash[:message] = "Account Updated"
        redirect to "/user/#{@user.id}"
      else
        flash[:message] = "Please type your Password"
        redirect to "/user/#{params[:id]}/edit"
      end
    end

      get '/user/:id' do
        if logged_in?
          erb :'users/profile'
        else
          redirect to '/'
        end
      end


        delete '/user/:id/delete' do
          if logged_in?
            current_user.delete
            redirect to "/logout"
          else
            redirect to '/'
          end
        
      end

      get '/logout' do
        if logged_in?
          session.destroy
        end 
          redirect to '/'
      end  
end
