require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  describe 'GET #index' do
    let!(:listing) { FactoryGirl.create(:listing) }
    it 'assigns all listings as @listings' do
      get :index, format: :json
      expect(assigns[:listings]).to eq([listing])
    end
  end
end
