class PlacesController < ApplicationController
  before '/places/:id/*' do
    @place = Place.find(params[:id])
  end

  before '/places/:id' do
    @place = Place.find(params[:id])
  end
  
  # all places
  get '/places' do
    @places = Place.all
    erb :'/places/index'
  end

  # new place
  get '/places/new' do
    # current_user?
    erb :'/places/new'
  end

  # create place
  post '/places' do
    # current_user?
    @place = Place.new(params[:place])
    if @place.save
      redirect "/places/#{@place.id}"
    else
      erb :'/places/new'
    end
  end

  # open place
  get '/places/:id' do
    @rating = rating
    erb :'/places/show'
  end

  # edit place
  get '/places/:id/edit' do
    # current_user?
    erb :'places/edit'
  end

  # update place
  post '/places/:id' do
    # current_user?
    @place.update_attributes(params[:place])
    if @place.save
      redirect "/places/#{@place.id}"
    else
      erb :'places/edit'
    end
  end

  # delete place
  post '/places/:id/delete' do
    # current_user?
    @place.delete
    redirect '/places'
  end

  # new review to place
  post '/places/:id/new_review' do
    # current_user?
    @user = User.find_by(id: session[:user_id])

    @review = @user.reviews.create(comment: params[:comment], grade: params[:grade].to_i)
    @review.place_id = @place.id

    erb :'/places/show' unless @review.save
    redirect "/places/#{@place.id}"
  end
end
