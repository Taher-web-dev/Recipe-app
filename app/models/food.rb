class Food < ApplicationRecord
  belongs_to :user
  validates :price, numericality: { greater_than: 0 }
end
