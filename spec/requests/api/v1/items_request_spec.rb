require "rails_helper"

describe "Items API" do
  it "Sends a list of Items" do
    merchant1 = Merchant.create!(name: "Al's Place")

    item1 = merchant1.items.create!(name: "item 1", description: "Good Item", unit_price: 2.1)
    item2 = merchant1.items.create!(name: "item 2", description: "Better Item", unit_price: 3.4)


    get "/api/v1/items"

    expect(response).to be_successful
  end

  it "can get an Item by its ID" do
    merchant1 = Merchant.create!(name: "Al's Place")

    item1 = merchant1.items.create!(name: "item 1", description: "Good Item", unit_price: 2.1)

    get "/api/v1/items/#{item1.id}"

    expect(response).to be_successful
  end
end