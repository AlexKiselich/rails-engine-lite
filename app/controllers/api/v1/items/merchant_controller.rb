class Api::V1::Items::MerchantController < ApplicationController
  def index
    merchant = Item.find(params[:item_id]).merchant_id
    render json: MerchantSerializer.new(Merchant.find(merchant))
  end
end