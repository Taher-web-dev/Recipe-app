require 'rails_helper'
RSpec.describe 'Foods List', type: :system do
  before :all do
    unless User.find_by(email: 'test@gmail.com')
      new_user = User.new(name: 'test', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
      new_user.skip_confirmation!
      new_user.save!
    end
  end
  it 'test recipes page functionnalities' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'User Name', with: 'test@gmail.com'
      fill_in 'Password', with: '123456'
    end
    new_user = User.find_by(email: 'test@gmail.com')
    click_button 'Login'
    visit "/foods/"
    expect(page).to have_content('No Food To Show')
    expect(page).to have_content('Add Food')
    unless Food.where(user_id: new_user.id).length >=1
      new_food = Food.new(name:'Apple', measurement_unit: 'g', price: 1.7, user: new_user)
      new_food.save!
    end
    food = Food.find_by(name:'Apple')
    visit "/foods"
    expect(page).to have_content('Food')
    expect(page).to have_content('Measurement Unit')
    expect(page).to have_content('Unit Price')
    expect(page).to have_content('Actions')
    expect(page).to have_content('Apple')
    expect(page).to have_content('g')
    expect(page).to have_content(1.7)
    expect(page).to have_content('Delete')
    click_button "Add Food"
    expect(page).to have_current_path("/users/#{new_user.id}/foods/new")
    visit "/foods"
    click_button "Delete"
    expect(page).to have_content('No Food To Show')
  end
end
