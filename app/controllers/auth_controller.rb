class AuthController < ApplicationController
  skip_before_action :authenticate_request # this will be implemented later
  api :POST, '/login', 'login'
  description 'will return auth token'
  param :email, String, desc: 'email' ,:required => true
  param :password, String, desc: 'password' ,:required => true
  def authenticate
    user = User.find_by_credentials(params[:email], params[:password]) # you'll need to implement this
    if user
      render json: { auth_token: user.generate_auth_token }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

end