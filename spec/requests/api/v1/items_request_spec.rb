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

  it "can create a new item" do
    merchant1 = Merchant.create!(name: "Al's Place")

    item_params = ({name: "Item 3",
                    description: "Greatest Item",
                    unit_price: 4.3,
                    merchant_id: merchant1.id})

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last
    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can delete an Item" do
    merchant1 = Merchant.create!(name: "Al's Place")

    item1 = merchant1.items.create!(name: "item 1", description: "Good Item", unit_price: 2.1)
    item2 = merchant1.items.create!(name: "item 2", description: "Better Item", unit_price: 3.4)

    expect(Item.count).to eq(2)

    delete "/api/v1/items/#{item2.id}"
    expect(response).to be_successful
    expect(Item.count).to eq(1)
    expect{Item.find(item2.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can update an item" do
    merchant1 = Merchant.create!(name: "Al's Place")

    previous_item1 = merchant1.items.create!(name: "item 1", description: "Good Item", unit_price: 2.1)

    updated_item_params = { name: "The best name for an item" }

    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{previous_item1.id}", headers: headers, params: JSON.generate({item: updated_item_params})

    item_updated = Item.find_by(id: previous_item1.id)

    expect(response).to be_successful
    expect(item_updated.name).to_not eq(previous_item1.name)
    expect(item_updated.name).to eq("The best name for an item")
  end

  it "can get an Item's merchant" do
    merchant1 = Merchant.create!(name: "Al's Place")
    item1 = merchant1.items.create!(name: "item 1", description: "Good Item", unit_price: 2.1)

    get "/api/v1/items/#{item1.id}/merchant"

    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a String

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to eq(merchant1.name)

  end

  describe "sad path & edge cases" do
    it "sad path, bad integer id returns 404" do
      item_id = 8923987297

      get "/api/v1/items/#{item_id}"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect{Item.find(item_id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end