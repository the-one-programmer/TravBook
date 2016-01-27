class CountriesController < ApplicationController
  skip_before_filter :authenticate_request
  def index
    @countries = Country.all
  end
end