class Api::V1::CartItemsController < ApplicationController
  before_action :set_cart, only: %i[index create]
  before_action :set_cart_item, only: %i[update destroy]

  def index
    render json: @cart.cart_items
  end

  def create
    @product = Product.find(params[:cart_item][:product_id])
    @cart_item = @cart.cart_items.find_by(product_id: @product.id)
    if @cart_item
      @cart_item.update(quantity: @cart_item.quantity + 1)
      render json: @cart_item, status: :ok
    else
      @cart_item = @cart.cart_items.build(product_id: @product.id, quantity: 1, price: @product.price)
      if @cart_item.save
        render json: @cart_item, status: :created
      else
        render json: { errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def update
    if @cart_item.update(params.require(:cart_item).permit(:quantity))
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

  def set_cart
    @cart = current_user.cart
  end

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end
end
