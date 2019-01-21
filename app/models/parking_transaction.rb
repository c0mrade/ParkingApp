# Representing single parking transaction
class ParkingTransaction < ApplicationRecord

  # associations
  belongs_to :floor
  # validations
  validates :ticket, presence: true, uniqueness: { scope: :active }
  validate :garage_full
  # delegations
  delegate :garage, to: :floor
  # scopes
  scope :active, -> { where(active: true) }
  # callbacks
  before_validation do
    self[:ticket] = SecureRandom.uuid
  end

  private
  # make sure ticket isn't modified by accident, should be geenrated
  # there are additional things we can do to make this truly unmutable but it was not necessary now
  attr_writer :ticket

  def garage_full
    if ParkingTransaction.active.where(floor: garage.floors).count == garage.capacity
      errors[:base] << 'Garage is full'
    end
  end
end
