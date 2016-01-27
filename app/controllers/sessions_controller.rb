class SessionsController < ApplicationController
  before_filter :authorize , :only => [:destroy]
  def new

  end

  def create
    if user = User.authenticate(params[:email],params[:password])
      session[:user_id] = user.id
      puts session[:user_id]
      render json: { message: 'Logged in' }, status: 200
    else
      render json: { message: 'Invalid combination of password and user email' }, status: 400
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: 'Logged out!' }, status: 200
  end
end
