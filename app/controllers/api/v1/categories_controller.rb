class Api::V1::CategoriesController < ApplicationController
  before_action :set_categroy, only: %i[show update destroy]

  def index
    @categories = Category.all
    render json: @categories
  end

  def show
    if @category
      render json: @category, status: :ok
    else
      render json: { error: 'Category was not found!' }, status: :not_found
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: :created
    else
      render json: { error: 'Category was not saved!' }, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      render json: @category
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_categroy
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
