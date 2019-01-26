# Representing garage location where we perform the parking
class Garage < ApplicationRecord
  validates :name, presence: true
  has_many :floors
  has_many :parking_transactions, through: :floors
  before_destroy :garage_vacated
  accepts_nested_attributes_for :floors, reject_if: :all_blank, allow_destroy: true

  def capacity
    floors&.sum(&:number_of_spaces) || 0
  end

  private

  def garage_vacated
    throw(:abort) if parking_transactions.active.any?
  end
end
