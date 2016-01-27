class InterestsController < ApplicationController
  skip_before_filter :authenticate_request

  api :GET, '/api/interests', 'interest list'
  description 'Create User Session'

  def index
    @interests = Interest.all
    #render json: @interests
  end
end