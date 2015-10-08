require 'rails_helper'

RSpec.describe ListingSearcher, type: :model do
  let(:searcher) { ListingSearcher.new(Listing) }

  it 'returns everything when called without search terms' do
    listing = create(:listing)
    expect(searcher.search({})).to contain_exactly(listing)
  end

  it 'returns listing with matching street' do
    create(:listing)
    listing = create(:listing, street: '123 street')
    expect(searcher.search(street: listing.street)).to contain_exactly(listing)
  end

  it 'returns listing with matching status' do
    create(:listing, status: 'pending')
    listing = create(:listing, status: 'sold')
    expect(searcher.search(status: listing.status)).to contain_exactly(listing)
  end

  it 'returns listing with matching price range' do
    listing_1 = create(:listing, price: 100000)
    listing_2 = create(:listing, price: 200000)
    listing_3 = create(:listing, price: 300000)
    expect(ListingSearcher.new(Listing).search(min_price: 200000, max_price: 300000)).to contain_exactly(listing_2, listing_3)
    expect(ListingSearcher.new(Listing).search(min_price: 100000)).to contain_exactly(listing_1, listing_2, listing_3)
    expect(ListingSearcher.new(Listing).search(min_price: 400000)).to eq([])
    expect(ListingSearcher.new(Listing).search(max_price: 200000)).to contain_exactly(listing_1, listing_2)
  end

  it 'returns listing with matching bedroom range' do
    listing_1 = create(:listing, bedrooms: 1)
    listing_2 = create(:listing, bedrooms: 2)
    listing_3 = create(:listing, bedrooms: 3)
    expect(ListingSearcher.new(Listing).search(min_bed: 2, max_bed: 3)).to contain_exactly(listing_2, listing_3)
    expect(ListingSearcher.new(Listing).search(min_bed: 1)).to contain_exactly(listing_1, listing_2, listing_3)
    expect(ListingSearcher.new(Listing).search(min_bed: 4)).to eq([])
    expect(ListingSearcher.new(Listing).search(max_bed: 2)).to contain_exactly(listing_1, listing_2)
  end

  it 'returns listing with matching bathroom range' do
    listing_1 = create(:listing, bathrooms: 1)
    listing_2 = create(:listing, bathrooms: 2)
    listing_3 = create(:listing, bathrooms: 3)
    expect(ListingSearcher.new(Listing).search(min_bath: 2, max_bath: 3)).to contain_exactly(listing_2, listing_3)
    expect(ListingSearcher.new(Listing).search(min_bath: 1)).to contain_exactly(listing_1, listing_2, listing_3)
    expect(ListingSearcher.new(Listing).search(min_bath: 4)).to eq([])
    expect(ListingSearcher.new(Listing).search(max_bath: 2)).to contain_exactly(listing_1, listing_2)
  end

  it 'returns listing with matching sq_ft range' do
    listing_1 = create(:listing, sq_ft: 100)
    listing_2 = create(:listing, sq_ft: 200)
    listing_3 = create(:listing, sq_ft: 300)
    expect(ListingSearcher.new(Listing).search(min_sq_ft: 200, max_sq_ft: 300)).to contain_exactly(listing_2, listing_3)
    expect(ListingSearcher.new(Listing).search(min_sq_ft: 100)).to contain_exactly(listing_1, listing_2, listing_3)
    expect(ListingSearcher.new(Listing).search(min_sq_ft: 400)).to eq([])
    expect(ListingSearcher.new(Listing).search(max_sq_ft: 200)).to contain_exactly(listing_1, listing_2)
  end
end
