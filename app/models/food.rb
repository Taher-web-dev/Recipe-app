class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_one :inventory_food
  validates :price, numericality: { greater_than: 0 }
end
