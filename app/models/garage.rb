# Representing garage location where we perform the parking
class Garage < ApplicationRecord
  validates :name, presence: true
  validate :must_have_floors
  before_destroy :garage_vacated
  has_many :floors, dependent: :destroy
  has_many :parking_transactions, through: :floors
  accepts_nested_attributes_for :floors, reject_if: :all_blank, allow_destroy: true

  def capacity
    floors&.sum(&:number_of_spaces) || 0
  end

  private

  def must_have_floors
    if floors.empty?
      errors[:base] << 'Garage cannot exist without any floors'
    end
  end

  def garage_vacated
    throw(:abort) if parking_transactions.active.any?
  end
end
