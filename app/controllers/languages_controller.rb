class LanguagesController < ApplicationController
  skip_before_filter :authenticate_request
  api :GET, '/languages', 'languages list'
  description 'list of all languages'
  def index
    @languages = Language.all
    #render json: @interests
  end
end