class ShoppingListsController < ActionController::Base
  def index
    @recipe_foods = RecipeFood.where(recipe_id: params[:recipe_id])
    @total_value = 0
    @recipe_foods.each do |element|
      @total_value += element.food.price * element.quantity
    end
  end
end
