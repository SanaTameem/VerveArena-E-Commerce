class Api::V1::CartsController < ApplicationController
  def show
    @cart = current_user.cart
    if @cart
      render json: @cart, status: :ok
    else
      render json: { error: 'Cart was not found!' }, status: :not_found
    end
  end

  # def create
  #   @cart = Cart.new()
  #   @cart.user_id = current_user.id
  #   if @cart.save
  #     render json: @cart, status: :created
  #   else
  #     render json: { errors: @cart.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # def update
  #   if @cart.update()
  #     render json: @cart
  #   else
  #     render json: {errors: @cart.errors.full_messages}, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   @cart = Cart.find(params[:id])
  #   if @cart.destroy
  #     render json: @cart
  #   else
  #     render json: {errors: @cart.errors.full_messages}, status: :unprocessable_entity
  #   end
  # end
end
