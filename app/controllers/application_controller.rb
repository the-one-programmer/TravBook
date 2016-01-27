class ApplicationController < ActionController::API

  protected
  def authorize
    puts "authorize"
    puts session[:user_id]
    unless User.find_by_id(session[:user_id])
      render json: { message: 'Not Logged in!' }, status: 401
    end
  end
end
