class Payment < ApplicationRecord
  belongs_to :order

  validates :paid_amount, presence: true, numericality: { greater_than: 0 }
  validates :payment_date, presence: true
  validates :order_id, presence: true
end
