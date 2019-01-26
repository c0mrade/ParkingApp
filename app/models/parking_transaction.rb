# Representing single parking transaction
class ParkingTransaction < ApplicationRecord

  # associations
  belongs_to :floor
  # validations
  validates :floor, presence: true
  validates :ticket, presence: true, uniqueness: { scope: :active }
  # delegations
  delegate :garage, to: :floor, allow_nil: true
  validate :garage_full, if: :new_record?
  # scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  # callbacks
  before_validation :generate_ticket

  private
  # make sure ticket isn't modified by accident, should be geenrated
  # there are additional things we can do to make this truly unmutable but it was not necessary now
  attr_writer :ticket

  def generate_ticket
    self[:ticket] = SecureRandom.uuid
  end

  def garage_full
    if ParkingTransaction.active.where(floor: garage.floors).count == garage.capacity
      errors[:base] << 'Garage is full'
    end
  end
end
