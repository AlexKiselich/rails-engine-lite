class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    begin
      render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: 'Merchant not found' } , status: 404
    end
  end
end