require 'csv'

class ListingImporter
  attr_accessor :file

  def initialize(file)
    @file = file
  end

  def run
    CSV.foreach(file, headers: true) do |row|
      hash = row.to_hash.except('id')
      Listing.create(hash)
    end
  end
end
