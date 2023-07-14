require "rails_helper"

describe "Merchants API" do
  it "Sends a list of books" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)
    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "can get a merchant by it's id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to eq("MyString")
  end

  it "can get a merchants items by its id" do
    merchant1 = Merchant.create!(name: "Al's Place")
    item1 = merchant1.items.create!(name: "item 1", description: "Good Item", unit_price: 2.1)
    item2 = merchant1.items.create!(name: "item 2", description: "Better Item", unit_price: 3.4)
    item3 = merchant1.items.create!(name: "item 3", description: "Best Item", unit_price: 4.5)

    get "/api/v1/merchants/#{merchant1.id}/items"

    merchant1_items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
  end
  it 'returns 400 or 404 for a bad merchant ID' do

    get "/api/v1/merchants/99999/items"

    expect(response).to have_http_status(:not_found).or have_http_status(:bad_request)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to have_key(:error)
    expect(data[:error]).to eq("Merchant not found")
  end
end