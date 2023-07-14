require "rails_helper"

RSpec.describe 'Item search requests' do
  describe "Find one Item by name fragment" do
    it "can find one Item by a name fragment" do
      merchant1 = Merchant.create!(name: "Al's Place")

      item1 = merchant1.items.create!(name: "basketball", description: "Good Item", unit_price: 2.1)
      item2 = merchant1.items.create!(name: "hockey puck", description: "Better Item", unit_price: 3.4)

      get "/api/v1/items/find?name=#{"bAll"}"
      expect(response).to be_successful
    end

    it "can search by prices" do
      merchant1 = Merchant.create!(name: "Al's Place")

      item1 = merchant1.items.create!(name: "basketball", description: "Good Item", unit_price: 48.2)
      item2 = merchant1.items.create!(name: "hockey puck", description: "Better Item", unit_price: 50)

      get "/api/v1/items/find?min_price=50"

      expect(response).to be_successful
    end
  end
end
