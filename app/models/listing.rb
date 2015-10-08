class Listing < ActiveRecord::Base
  scope :search, ->(terms) { ListingSearcher.search(self, terms) }
end
