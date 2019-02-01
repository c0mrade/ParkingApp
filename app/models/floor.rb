# Representing physical space where the parking spaces are located
class Floor < ApplicationRecord
  belongs_to :garage, inverse_of: :floors
  before_destroy :floor_vacated
  has_many :parking_transactions, dependent: :destroy
  validates :garage, presence: true
  validates :number_of_spaces, presence: true

  def floor_vacated
    throw(:abort) if parking_transactions.active.any?
  end
end
