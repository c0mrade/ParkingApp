# Representing physical space where the parking spaces are located
class Floor < ApplicationRecord
  belongs_to :garage
  has_many :parking_transactions
  validates :garage, presence: true
  validates :number_of_spaces, presence: true
end
