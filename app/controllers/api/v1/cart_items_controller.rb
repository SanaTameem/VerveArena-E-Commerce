class Api::V1::CartItemsController < ApplicationController
  before_action :set_cart, only: %i[index create]
  before_action :set_cart_item, only: %i[update destroy]
  before_action :cart_item_params, only: %i[create update]

  def index
    render json: @cart.cart_items
  end

  def create
    @product = Product.find(params[:cart_item][:product_id])
    @cart_item = @cart.cart_items.find_by(product_id: @product.id)
    if @cart_item
      new_quantity = @cart_item.quantity + 1
      @cart_item.update(cart_item_params.merge(quantity: new_quantity))
      render json: @cart_item, status: :ok
    else
      @cart_item = @cart.cart_items.build(cart_item_params.merge(quantity: 1, price: @product.price))
      if @cart_item.save
        render json: @cart_item, status: :created
      else
        render json: { errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def update
    quantity = params[:cart_item][:quantity].to_i
    @product = Product.find(params[:cart_item][:product_id])
    if @cart_item.update(cart_item_params.merge(quantity:, price: @product.price))
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

  def cart_item_params
    params.require(:cart_item).permit(:product_id)
  end
end
