class Api::V1::CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[update destroy]

  def index
    @cart = Cart.find(params[:cart_id])
    render json: @cart.cart_items
  end

  def create
    @cart = Cart.find(params[:cart_id])
    @product = Product.find(params[:cart_item][:product_id])
    @cart_item = @cart.cart_items.build(product_id: @product.id, quantity: 1)
    if @cart_item.save
      render json: @cart_item, status: :created
    else
      render json: { errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @cart_item.update(params.require(:cart_item).permit(:product_id, :quantity))
      render json: @cart_item, status: :ok
    else
      render json: { errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @cart_item.destroy
      render json: @cart_item
    else
      render json: { errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end
end
