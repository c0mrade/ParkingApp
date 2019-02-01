module ParkingTransactionHelper
  # select all that have less occupancy than number of spaces also
  # select who have no occupancy, hence the left join
  def available_floors_with_parking_spaces
    Floor.where(id:
      Floor
        .select('count(parking_transactions.id) as cnt', 'floors.id as floor_id', 'number_of_spaces')
        .joins('left join parking_transactions on parking_transactions.floor_id = floors.id')
        .where('parking_transactions.active = ? or parking_transactions.id is null', true)
        .group('floor_id, number_of_spaces')
        .having('cnt < number_of_spaces')
        .collect(&:floor_id)
    )
  end
end