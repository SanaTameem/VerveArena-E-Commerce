class Api::V1::PaymentsController < ApplicationController
  before_action :set_order, only: %i[show create destroy]
  def show
    @payment = @order.payment
    if @payment
      render json: @payment, status: :ok
    else
      render json: { error: 'Payment was not found!' }, status: :not_found
    end
  end

  def create
    @payment = Payment.new(paid_amount: @order.total_amount, payment_date: Date.today)
    @payment.order = @order
    if @payment.save
      render json: @payment, status: :created
    else
      render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @payment = @order.payment
    if @payment.destroy
      render json: @payment
    else
      render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end
end
