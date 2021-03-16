require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # enables cookie based sessions
    enable :sessions
    set :session_secret, "password_security"
  end

  # renders the erb file for the root route
  get "/" do
    erb :index
  end

  # defines helper methods to be inheritted by all controllers
  helpers do
    # returns a boolean whether a user is logged in
    def logged_in?
      !!session[:user_id]
    end

    # finds the Teacher instance whose id matches the user_id found in the session params)
    def current_user
      Teacher.find(session[:user_id])
    end
  end

end
