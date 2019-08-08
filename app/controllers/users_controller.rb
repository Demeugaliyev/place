require 'bcrypt' # can take require from application_controller

def crypt_password(password)
  BCrypt::Password.create(password).to_s
end

def test_password(password, hash)
  BCrypt::Password.new(hash) == password
end

class UsersController < ApplicationController
  # new user
  get '/users/new' do
    erb :'/users/new.html'
  end

  # create user
  post '/create_user' do
    # !current_user?
    @user = User.new(username: params[:username], email: params[:email],
                     password: crypt_password(params[:password]))
    if @user.save
      redirect '/'
    else
      flash[:error] = 'Wrong input'
      redirect '/users/new'
    end
  end

  # user sign in
  get '/sign_in' do
    # !current_user?
    erb :'/users/sign_in.html'
  end

  # start user session
  post '/sign_in' do
    # !current_user?
    user = User.find_by(email: params[:email])
    if user && test_password(params[:password], user.password)
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:error] = 'Email or password was incorrect'
      erb :'/users/sign_in.html'
    end
  end

  # stop user session
  post '/sign_out' do
  # current_user?
    session.destroy
    redirect '/sign_in'
  end
end
