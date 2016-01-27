class SessionsController < ApplicationController
  before_filter :authorize , :only => [:destroy]
  def new

  end

  api :POST, '/api/login', 'Login'
  description 'Create User Session'
  param :email, String, desc: 'email of the user', :required => true
  param :password, String, desc: 'password', :required => true

  def create
    if user = User.authenticate(params[:email],params[:password])
      session[:user_id] = user.id
      puts session[:user_id]
      render json: { message: 'Logged in' }, status: 200
    else
      render json: { message: 'Invalid combination of password and user email' }, status: 400
    end
  end

  api :POST, '/api/logout', 'logout'
  description 'destroy the current User Session'

  error 401, 'Not Logged in'
  def destroy
    session[:user_id] = nil
    render json: { message: 'Logged out!' }, status: 200
  end

  api :GET, '/api/current_user', 'information of the current logged in user'
  description 'return null if not logged in'
  param :user_id, Integer
  param :name, String

  def current_user
    if session[:user_id]
      render json: { user_id: session[:user_id], name:User.find(session[:user_id]).name}
    else
      render json: { user_id: nil}
    end

  end
end
