class LanguagesController < ApplicationController
  def index
    @languages = Language.all
    #render json: @interests
  end
end