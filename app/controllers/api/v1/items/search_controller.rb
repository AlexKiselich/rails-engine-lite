class Api::V1::Items::SearchController < ApplicationController
  def index
  if params[:name].present?
    item = Item.find_by_name(params[:name]).first
      if item
        render json: ItemSerializer.new(item)
      else
        render json: ItemSerializer.new(Item.new)
      end
  elsif params[:min_price].present?
    item = Item.find_by_min_price(params[:min_price]).first
      if item
        render json: ItemSerializer.new(item)
      else
        render json: ItemSerializer.new(Item.new)
      end
  elsif params[:max_price].present?
      item = Item.find_by_max_price(params[:max_price]).first
      if item
        render json: ItemSerializer.new(item)
      else
        render json: ItemSerializer.new(Item.new)
      end
    end
  end
end