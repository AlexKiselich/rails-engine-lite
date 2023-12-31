class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    begin
      render json: ItemSerializer.new(Item.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: 'Item not found' } , status: 404
    end
  end

  def create
    item = Item.create(item_params)
    if item.save
      render json: ItemSerializer.new(Item.create(item_params)), status: 201
    end
  end

  def destroy
    render json: ItemSerializer.new(Item.find(params[:id]).destroy) , status: 201
  end

  def update
    item = Item.update(params[:id], item_params)
    if item.save
      render(json: ItemSerializer.new(Item.update(params[:id], item_params)))
    else
      render :status => 404
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end