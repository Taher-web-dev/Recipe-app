require 'rails_helper'
RSpec.describe 'public recipes', type: :system do
  before :all do
    unless User.find_by(email: 'test@gmail.com')
      new_user = User.new(name: 'test', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
      new_user.skip_confirmation!
      new_user.save!
    end
  end
  it 'test public recipes page functionnalities' do
    new_user = User.find_by(email: 'test@gmail.com')
    unless Recipe.where(user_id: new_user.id).length >= 1
      recipe1 = Recipe.new(name: 'couscous', public: true, user: new_user)
      recipe1.save!
    end
    visit new_user_session_path
    within('#new_user') do
      fill_in 'User Name', with: 'test@gmail.com'
      fill_in 'Password', with: '123456'
    end
    click_button 'Login'
    click_button 'Public recipes'
    expect(page).to have_content('couscous')
    expect(page).to have_content('test')
    click_link('test')
    id = Recipe.find_by(name: 'couscous').id
    expect(page).to have_current_path("/users/#{new_user.id}/recipes/#{id}")
    expect(page).to have_css("img[src*='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOWry5OIVtLKR-JVVI4cjFYMPJm5sSFNOF4w&usqp=CAU']")
  end
end
