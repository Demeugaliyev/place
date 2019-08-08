class PlacesController < ApplicationController
  MIN_RATING_WITHOUT_COMMENT = 4
  COMMENT_MIN_SIZE = 5

  # all places
  get '/places' do
    @places = Place.all
    erb :'/places/index.html'
  end

  # new place
  get '/places/new' do
    # current_user?
    erb :'/places/new.html'
  end

  # create place
  post '/places' do
    # current_user?
    @place = Place.new params
    if @place.save
      redirect "/places/#{@place.id}"
    else
      flash[:error] = @place.errors.full_messages.first
      redirect '/places/new'
    end
  end

  # open place
  get '/places/:id' do
    @place = Place.find(params[:id])
    if @place.reviews.any?
      grades = 0
      @place.reviews.each { |review| grades += review.grade }
      @rating = grades / @place.reviews.size
    end
    erb :'/places/show.html'
  end

  # edit place
  get '/places/:id/edit' do
    # current_user?
    @place = Place.find(params[:id])
    erb :'/places/edit.html'
  end

  # update place
  post '/places/:id' do
    # current_user?
    @place = Place.find(params[:id])
    # require 'pry'
    # binding.pry
    @place.name = params[:name]
    @place.description = params[:description]
    @place.short_description = params[:short_description]
    @place.picture_url = params[:picture_url]
    @place.latitude = params[:latitude]
    @place.longitude = params[:longitude]
    if @place.save
      redirect "/places/#{@place.id}"
    else
      flash[:error] = @place.errors.full_messages.first
      erb :'/places/edit.html'
    end
  end

  # delete place
  post '/places/:id/delete' do
    # current_user?
    @place = Place.find(params[:id])
    @place.delete
    redirect '/places'
  end

  # new review to place
  post '/places/:id/new_review' do
    # current_user?
    @place = Place.find(params[:id])
    if params[:grade].to_i < MIN_RATING_WITHOUT_COMMENT && params[:comment].size < COMMENT_MIN_SIZE
      flash[:error] = 'if grade < 4 need comment'
    else
      @user = User.find_by(id: session[:user_id])
      @review = @user.reviews.create(comment: params[:comment], grade: params[:grade].to_i)
      @review.place_id = @place.id
      @review.save
      flash[:success] = "#{@place.name} was successfully created"
    end
    redirect "/places/#{@place.id}"
  end
end
