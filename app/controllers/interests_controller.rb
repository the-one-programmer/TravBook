class InterestsController < ApplicationController
  api :GET, '/api/interests', 'interest list'
  description 'Create User Session'

  def index
    @interests = Interest.all
    #render json: @interests
  end
end