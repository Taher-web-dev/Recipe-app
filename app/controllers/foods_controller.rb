class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit update destroy]

  # GET /foods or /foods.json
  def index
    @foods = Food.where(user_id: current_user.id)
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id

    if @food.save
      redirect_to '/foods/'
    else
      render :new, alert: 'Sorry something went wrong'
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    food = Food.find(params[:id])
    food.destroy
    redirect_to '/foods/'
  end

  private

  def set_food
    Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
