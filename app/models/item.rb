class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_by_name(fragment)
    where("name ILIKE '%#{fragment}%'").order(:name)
  end

  def self.find_by_min_price(min_price)
    where("unit_price >= #{min_price}").order(:name)
  end

  def self.find_by_max_price(max_price)
    where("unit_price <= #{max_price}").order(:name)
  end
end
