require 'rails_helper'

RSpec.describe Merchant, type: :model do
 describe "class methods" do
  describe "find_by_name" do
    it "can find any merchant by a fragment of the name" do
    fragment = "Al"
    merchant1 = Merchant.create!(name: "Al's Place")
    merchant2 = Merchant.create!(name: "Alex's Spot")
    merchant3 = Merchant.create!(name: "Ben's Spot")

    expect(Merchant.find_all_by_name(fragment)).to eq([merchant1,merchant2])
    end
  end
 end
end
