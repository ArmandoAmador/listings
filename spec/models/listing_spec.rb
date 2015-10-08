require 'rails_helper'

RSpec.describe Listing, type: :model do

  describe 'database structure' do
    it { is_expected.to have_db_column(:street).of_type(:string) }
    it { is_expected.to have_db_column(:status).of_type(:string) }
    it { is_expected.to have_db_column(:price).of_type(:integer) }
    it { is_expected.to have_db_column(:bedrooms).of_type(:integer) }
    it { is_expected.to have_db_column(:bathrooms).of_type(:integer) }
    it { is_expected.to have_db_column(:sq_ft).of_type(:integer) }
    it { is_expected.to have_db_column(:lat).of_type(:float) }
    it { is_expected.to have_db_column(:lng).of_type(:float) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe '.search' do
    it 'delegates to the listing searcher' do
      terms = { price: 100_00 }
      expect(ListingSearcher).to receive(:search).with(Listing, terms)
      Listing.search(terms)
    end
  end
end
