class UsersController < ApplicationController

  def new
    @user = User.new
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