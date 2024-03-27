class Payment < ApplicationRecord
  belongs_to :order

  validates :paid_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :payment_date, presence: true
  validates :order_id, presence: true
  # validate :check_order_payment, on: :create

  # def check_order_payment
  #   return unless order && order.payment.present?

  #   errors.add(:base, 'Payment has already been made for this order')
  # end
end
