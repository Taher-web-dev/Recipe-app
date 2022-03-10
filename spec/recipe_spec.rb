require 'rails_helper'
RSpec.describe 'recipe', type: :system do
  before :all do
    unless User.find_by(email: 'test@gmail.com')
      new_user = User.new(name: 'test', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
      new_user.skip_confirmation!
      new_user.save!
    end
  end
  it 'test recipes page functionnalities' do
    new_user = User.find_by(email: 'test@gmail.com')
    unless Recipe.where(user_id: new_user.id).length >= 1 
        recipe_1 = Recipe.new(name: 'couscous', public: true, user: new_user)
        recipe_1.save!
    end
    visit new_user_session_path
    within('#new_user') do
      fill_in 'User Name', with: 'test@gmail.com'
      fill_in 'Password', with: '123456'
    end
    user = User.find_by(email: 'test@gmail.com')
    recipe = Recipe.find_by(name: 'couscous')
    click_button 'Login'
    visit "users/#{user.id}/recipes/#{recipe.id}"
    expect(page).to have_content('Food')
    expect(page).to have_content('Quantity')
    expect(page).to have_content('Value')
    expect(page).to have_content('Actions')
    
    click_button 'Generate shopping list'
    expect(page).to have_current_path('/shopping_list')
  end
end