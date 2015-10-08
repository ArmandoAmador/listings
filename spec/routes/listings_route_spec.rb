require 'rails_helper'

RSpec.describe ListingsController, type: :routing do
  it { expect(get: '/listings').to route_to('listings#index') }
end
