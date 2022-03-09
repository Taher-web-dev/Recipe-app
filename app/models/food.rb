class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  validates :price, numericality: { greater_than: 0 }
end
