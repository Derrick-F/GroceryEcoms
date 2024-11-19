class Item < ApplicationRecord
  belongs_to :category
  has_many :cart_items

  def sold_by_weight?
    self.unit_type == "weight"
  end
end
