class ShoppingListController < ApplicationController
  def index
    @recipes = Recipe.where(user_id: current_user.id)
    @missing_foods = []
    @quantity = []
    @prices = []
    inv_d = Inventory.find_by(user_id: current_user.id)
    @recipes.each do |recipe|
      rfoods = RecipeFood.where(recipe_id: recipe.id)
      rfoods.each do |f|
        rq = f.quantity
        eq = InventoryFood.find_by(food_id: f.food_id, inventory_id: inv_d).quantity
        dq = rq - eq
        next unless dq.positive?

        @missing_foods.push(Food.find(f.food_id))
        @quantity.push(dq)
        @prices.push(dq * Food.find(f.food_id).price)
      end
    end
    @amount_item = @missing_foods.size
    @total_value = 0
    @prices.each do |p|
      @total_value += p
    end
  end
end
