class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :cart_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
