class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_one :payment

  validates :user_id, presence: true
  validates :order_date, presence: true
  validates :status, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
