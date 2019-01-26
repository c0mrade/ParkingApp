module ApplicationHelper
  def garage_occupancy_ratio
    number_to_percentage((ParkingTransaction.active.count.to_f / Garage.all.map(&:capacity).sum) * 100, precision: 2 )
  end

  def available_parking_spaces
    Garage.all.map(&:capacity).sum - ParkingTransaction.active.count
  end
end
