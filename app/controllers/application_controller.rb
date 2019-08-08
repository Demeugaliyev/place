require './config/environment'
require 'sinatra/base'
require 'sinatra/flash'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Session
    use Rack::Flash
  end

  get '/' do
    @places = Place.all
    erb :'/places/index.html'
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
end