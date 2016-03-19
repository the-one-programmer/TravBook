class InterestsController < ApplicationController
  skip_before_filter :authenticate_request

  api :GET, '/interests', 'interest list'
  description 'list of all interests'

  def index
    @interests = Interest.all
    #render json: @interests
  end
end