# Representing garage location where we perform the parking
class Garage < ApplicationRecord
  validates :name, presence: true
  has_many :floors
  has_many :parking_transactions, through: :floors

  def capacity
    floors.sum(&:number_of_spaces)
  end
end
