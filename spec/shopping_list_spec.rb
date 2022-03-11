require 'rails_helper'
RSpec.describe 'Foods List', type: :system do
  before :all do
    unless User.find_by(email: 'test@gmail.com')
      new_user = User.new(name: 'test', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
      new_user.skip_confirmation!
      new_user.save!
    end
  end
  it 'test shopping list page functionnalities' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'User Name', with: 'test@gmail.com'
      fill_in 'Password', with: '123456'
    end
    new_user = User.find_by(email: 'test@gmail.com')
    click_button 'Login'
    visit "/shopping_list/"
    expect(page).to have_content('Shopping List')
    expect(page).to have_content('Amount of food items to buy')
    expect(page).to have_content('Total value of food needed')
    expect(page).to have_content('Food')
    expect(page).to have_content('Quantity')
    expect(page).to have_content('Price')
    unless Recipe.where(user_id: new_user.id).length >=1
      recipe = Recipe.new(name:'couscous',public: true, user: new_user)
      recipe.save!
    end
    new_recipe = Recipe.find_by(name: 'couscous')
    unless Food.where(user_id: new_user.id).length >=1
      food = Food.new(name:'meat',measurement_unit: 'g', price: 2, user: new_user)
      food.save!
    end
    food = Food.find_by(name: 'meat')
    unless Inventory.where(user_id: new_user.id).length >= 1
      new_inv = Inventory.new(name:'racket', user: new_user)
      new_inv.save!
    end
    inv = Inventory.find_by(name:'racket')
    unless InventoryFood.where(food_id: food.id).length >= 1
      new_inv_food = InventoryFood.new(quantity: 5, inventory: inv, food: food)
      new_inv_food.save!
    end
    inv_food = InventoryFood.find_by(food_id: food.id)
    
    unless RecipeFood.where(food_id: food.id).length >= 1
      new_recipe_food = RecipeFood.new(quantity: 10, recipe: new_recipe, food: food)
      new_recipe_food.save!
    end
    visit "/shopping_list/"
    sleep 10
    expect(page).to have_content('Amount of food items to buy: 1')
    expect(page).to have_content('Total value of food needed: $10.0')
    expect(page).to have_content('meat')
    expect(page).to have_content('5.0 g')
  end
end
