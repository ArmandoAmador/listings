class ListingsController < ApplicationController
  def index
    @listings = paginate Listing.search(search_params), per_page: 100
    @listings_geojson = ListingGeojson.new(@listings).geojson

    respond_to do |format|
      format.html
      format.json { render json: @listings_geojson }
    end
  end

  private

  def search_params
    params.slice(
      :street, :status, :min_bed, :max_bed, :min_bath,
      :max_bath, :min_price, :max_price, :min_sq_ft, :max_sq_ft
    )
  end
end
