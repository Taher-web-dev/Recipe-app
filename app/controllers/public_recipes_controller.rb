class PublicRecipesController < ApplicationController
  layout 'public_recipes'
  def index
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end
end
