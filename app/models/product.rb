class Product < ApplicationRecord
  belongs_to :sub_category
  has_many :cart_items
  has_many :order_items

  serialize :size, Array, coder: JSON
  serialize :color, Array, coder: JSON
  serialize :image_url, Array, coder: JSON
end
