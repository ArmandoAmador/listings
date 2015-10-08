namespace :import do
  desc 'Import listings from csv'
  task listings: :environment do
    filename = File.join Rails.root, 'listings.csv'
    ListingImporter.new(filename).run
  end
end
