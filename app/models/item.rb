class Item < ApplicationRecord
  belongs_to :category
  has_many :cart_items
end