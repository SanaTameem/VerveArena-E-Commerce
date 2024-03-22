class Order < ApplicationRecord
  belongs_to :user
  # has_many :order_items
  has_one :payment, dependent: :destroy

  validates :user_id, presence: true
  validates :order_date, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending shipped delivered cancelled] }
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
