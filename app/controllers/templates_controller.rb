# class TemplatesController < ApplicationController
#   def index
#     @category = Category.find_by(name: params[:category].downcase)

#     if @category
#       @templates = @category.templates.includes(image_attachment: :blob)
#     else
#       redirect_to categories_path, alert: "Category not found."
#     end
#   end
  
#   def template_params
#     params.require(:template).permit(:name, :category_id, :image)
#   end
  

# end


class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  def index
    @category = Category.find_by(name: params[:category].downcase)

    if @category
      @templates = @category.templates.includes(image_attachment: :blob)
    else
      redirect_to categories_path, alert: "Category not found."
    end
  end

  def show
    # This action displays a single template (e.g., a full preview or detailed view)
  end

  def edit
    # This will load the edit form for the selected template
  end

  def update
    if @template.update(template_params)
      redirect_to @template, notice: "Template updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @template.destroy
    redirect_to templates_path(category: @template.category.name), notice: "Template deleted successfully."
  end

  private

  def set_template
    @template = Template.find(params[:id])
  end

  def template_params
    params.require(:template).permit(:name, :category_id, :image)
  end
end

