class UsersController < ApplicationController

    get '/login' do
        if logged_in?
          redirect to "/main"
        else 
          redirect to "/"
        end
      end

      post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to "/main"
        else
          flash[:message] = "Account not found"
          redirect to '/signup'
        end
      end

      get '/signup' do
        if !logged_in?
          erb :'users/new_user', :layout => :'login_layout'
        else
          redirect to '/main'
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
          redirect to "/main"
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
