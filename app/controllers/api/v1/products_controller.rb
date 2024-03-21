class Api::V1::ProductsController < ApplicationController
  before_action :set_sub_category
  before_action :set_product, only: %i[show update destroy]
  def index
    @products = @sub_category.products
    render json: @products
  end

  def show
    if @product
      render json: @product, status: :ok
    else
      render json: { error: 'Product was not found!' }, status: :not_found
    end
  end

  def create
    @product = @sub_category.products.new(product_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_sub_category
    @sub_category = SubCategory.find(params[:sub_category_id])
  end

  def set_product
    @product = @sub_category.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name, :description, :gender_target, :rating, :price, :stock_quantity, size: [], color: [], image_url: []
    )
  end
end
