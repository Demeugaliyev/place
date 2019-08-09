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
    # require 'pry'
    # binding.pry
    erb :'/places/index'
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def rating
      if @place.reviews.any?
        grades = 0
        @place.reviews.each { |review| grades += review.grade }
        grades / @place.reviews.size
      else
        nil
      end
    end
  end
end
