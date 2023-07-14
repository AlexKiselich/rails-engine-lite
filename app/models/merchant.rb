class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def self.find_all_by_name(fragment)
    where("name ILIKE ?", "%#{fragment}%").order(:name)
  end
end
