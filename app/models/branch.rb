class Branch < ApplicationRecord
  validates :fridge, uniqueness: true
end
