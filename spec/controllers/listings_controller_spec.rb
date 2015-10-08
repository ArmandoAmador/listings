require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  describe 'GET #index' do
    let!(:listing) { FactoryGirl.create(:listing) }
    let(:geojson_listing) { ListingGeojson.new([listing]) }

    it 'assigns all listings as @listings' do
      get :index, {}, 'Accept' => 'application/json'
      expect(response.status).to eq 200

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to include(geojson_listing.geojson)
    end
  end
end
