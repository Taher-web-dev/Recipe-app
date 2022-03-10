class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def show
    recip_id = params[:id]
    @recipe = Recipe.find(recip_id)
    render recipes_path unless (@recipe.public == true) || (@recipe.user_id == current_user.id)
    @recipe_foods = RecipeFood.where(recipe_id: recip_id)
  end

  def new
    @recipe = Recipe.new
  end

  def edit; end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      redirect_to '/recipes/'
    else
      render :new, alert: 'Sorry something went wrong'
    end
  end

  def update; end

  def destroy
    @recipe.destroy
    redirect_to '/recipes/'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
