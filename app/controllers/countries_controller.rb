class CountriesController < ApplicationController
  skip_before_filter :authenticate_request
  api :GET, '/countries', 'countries list'
  description 'list of all countries'
  def index
    @countries = Country.all
  end
end