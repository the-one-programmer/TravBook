class UsersController < ApplicationController

  def new
    @user = User.new
  end

  api :POST, '/api/register', 'Create User'
  description 'Create user with specifed user params'
  param :user, Hash, desc: 'User information', :required => true do
    param :name, String, desc: 'Full name of the user', :required => true
    param :email, String, desc: 'email of the user', :required => true
    param :password, String, desc: 'password', :required => true
    param :gender,["male","female"], desc: 'yes, no transgender yet sorry', :required => true
    param :city_id, Integer, desc: 'city id mapped to a city in db', :required => true
  end
  def create
    @user = User.new(user_params)
      if @user.save
        render json: { message: 'Account successfully created!' }, status: 200
      else
        render json: { message: @user.errors}, status: 400
      end

  end

  private

  def user_params
    params.permit(:name, :email, :password,:gender, :city_id)
  end

end