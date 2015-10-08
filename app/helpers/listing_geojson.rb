class ListingGeojson
  attr_accessor :listings

  def initialize(listings)
    @listings = listings
  end

  def geojson
    {
      type: 'FeatureCollection',
      features: features
    }
  end

  private

  def features
    listings.map do |listing|
      {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [listing.lng, listing.lat]
        },
        properties: {
          id: listing.id,
          price: listing.price,
          street: listing.street,
          bedrooms: listing.bedrooms,
          bathrooms: listing.bathrooms,
          sq_ft: listing.sq_ft
        }
      }
    end
  end
end
