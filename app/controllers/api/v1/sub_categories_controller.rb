class Api::V1::SubCategoriesController < ApplicationController
  before_action :set_category
  before_action :set_sub_category, only: %i[show update destroy]
  def index
    @sub_categories = @category.sub_categories
    render json: @sub_categories
  end

  def show
    if @sub_category
      render json: @sub_category, status: :ok
    else
      render json: { error: 'Sub Category was not found!' }, status: :not_found
    end
  end

  def create
    @sub_category = @category.sub_categories.new(sub_category_params)
    if @sub_category.save
      render json: @sub_category, status: :created
    else
      render json: { error: 'Sub category was not saved!' }, status: :unprocessable_entity
    end
  end

  def update
    if @sub_category.update(sub_category_params)
      render json: @sub_category, status: :ok
    else
      render json: { errors: @sub_category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @sub_category.destroy
      render json: @sub_category
    else
      render json: { errors: @sub_category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_sub_category
    @sub_category = @category.sub_categories.find(params[:id])
  end

  def sub_category_params
    params.require(:sub_category).permit(:name)
  end
end
