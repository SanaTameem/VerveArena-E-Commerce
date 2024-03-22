class Api::V1::OrdersController < ApplicationController
  before_action :set_user, only: %i[index create]
  before_action :set_order, only: %i[show update destroy]
  def index
    @orders = @user.orders
    render json: @orders
  end

  def show
    if @order
      render json: @order, status: :ok
    else
      render json: { error: 'Order was not found!' }, status: :not_found
    end
  end

  def create
    @cart = Cart.find_by(user_id: params[:user_id])
    if @cart.nil?
      render json: { error: 'Cart was not found!' }, status: :not_found
      return
    end
    @order = @user.orders.build(order_date: Date.today, status: 'pending',
                                total_amount: calculate_total_amount(@cart.cart_items))
    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order, status: :ok
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @order.destroy
      render json: @order
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end

  def calculate_total_amount(items)
    total_amount = 0
    items.each do |item|
      total_amount += (item.price * item.quantity)
    end
    total_amount
  end
end
