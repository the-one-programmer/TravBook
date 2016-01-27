class LanguagesController < ApplicationController
  skip_before_filter :authenticate_request
  def index
    @languages = Language.all
    #render json: @interests
  end
end