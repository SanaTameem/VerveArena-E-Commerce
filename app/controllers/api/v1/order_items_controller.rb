# class Api::V1::OrderItemsController < ApplicationController
#   before_action :set_order, only: [:index, :create]
#   before_action :set_order_item, only: [:update, :destroy]
#   def index
#     render json: @order.order_items
#   end

#   def create
#     @product = Product.find(params[:order_item][:product_id])
#     @order_item = @order.order_items.build(product_id: @product.id, price: @product.price, quantity: 1)
#     if @order_item.save
#       render json: @order_item, status: :created
#     else
#       render json: {errors: @order_item.errors.full_messages}, status: :unprocessable_entity
#     end
#   end

#   def update
#     if @order_item.update(params.require(:order_item).permit(:quantity))
#       render json: @order_item, status: :ok
#     else
#       render json: {errros: @order_item.errors.full_messages}, status: :unprocessable_entity
#     end
#   end

#   def destroy
#     if @order_item.destroy
#       render json: @order_item
#     else
#       render json: {errros: @order_item.errors.full_messages}, status: :unprocessable_entity
#     end
#   end

#   private
#   def set_order
#     @order = Order.find(params[:order_id])
#   end

#   def set_order_item
#     @order_item = OrderItem.find(params[:id])
#   end
# end
