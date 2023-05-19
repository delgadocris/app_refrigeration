class Branch < ApplicationRecord
  belongs_to :user

  validates :fridge, uniqueness: true

  def get_icon
    return "cold" if temperature.to_f < 0

    "hot"
  end
end
