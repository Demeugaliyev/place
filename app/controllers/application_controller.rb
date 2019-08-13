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
    erb :'/places/index'
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def rating
      return 0 if @place.reviews.empty?
      grades = @place.reviews.map(&:grade)
      grades.sum / @place.reviews.size
    end

    def placemarks
      placemarks = []
      @places.each do |place|
        placemarks.push([
        [ [place.latitude ], [ place.longitude ] ],
        [ place.name ],
        [ [ place.short_description ], [ place.picture_url ] ]                        
      ])
      end
      placemarks
    end
  end
end
