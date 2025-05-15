class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(name: params[:id])
    @templates = @category.templates.includes(image_attachment: :blob)
  end
end
