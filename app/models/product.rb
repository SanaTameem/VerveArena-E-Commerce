class Product < ApplicationRecord
  belongs_to :sub_category
  has_many :cart_items
  has_many :order_items

  serialize :size, Array, coder: JSON
  serialize :color, Array, coder: JSON
  serialize :image_url, Array, coder: JSON

  validates :sub_category_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :image_url, presence: true
  validates :gender_target, inclusion: { in: %w[men women kids] }, allow_nil: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 },
                     allow_nil: true
end
