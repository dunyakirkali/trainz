class CountriesController < ApplicationController
  def index
    render json: ISO3166::Country.all_translated
  end
end
