class ListingSearcher
  def self.search(collection, terms)
    new(collection).search(terms)
  end

  def initialize(collection)
    @collection = collection
  end

  def search(terms)
    search_by_street(terms[:street])
    search_by_status(terms[:status])
    search_by_price(min_price: terms[:min_price], max_price: terms[:max_price])
    search_by_bedrooms(min_bed: terms[:min_bed], max_bed: terms[:max_bed])
    search_by_bathrooms(min_bath: terms[:min_bath], max_bath: terms[:max_bath])
    search_by_sq_ft(min_sq_ft: terms[:min_sq_ft], max_sq_ft: terms[:max_sq_ft])
    @collection.all
  end

  private

  def search_by_street(street)
    @collection = @collection.where(street: street) if street
  end

  def search_by_status(status)
    @collection = @collection.where(status: status) if status
  end

  def search_by_price(options)
    @collection = @collection.where('price >= ?', options[:min_price]) if options[:min_price].present?
    @collection = @collection.where('price <= ?', options[:max_price]) if options[:max_price].present?
  end

  def search_by_bedrooms(options)
    @collection = @collection.where('bedrooms >= ?', options[:min_bed]) if options[:min_bed].present?
    @collection = @collection.where('bedrooms <= ?', options[:max_bed]) if options[:max_bed].present?
  end

  def search_by_bathrooms(options)
    @collection = @collection.where('bathrooms >= ?', options[:min_bath]) if options[:min_bath].present?
    @collection = @collection.where('bathrooms <= ?', options[:max_bath]) if options[:max_bath].present?
  end

  def search_by_sq_ft(options)
    @collection = @collection.where('sq_ft >= ?', options[:min_sq_ft]) if options[:min_sq_ft].present?
    @collection = @collection.where('sq_ft <= ?', options[:max_sq_ft]) if options[:max_sq_ft].present?
  end
end
