module ParkingTransactionHelper
  def available_floors_with_parking_spaces
    Floor.where(id:
      Floor
        .select('count(parking_transactions.id) as cnt', 'floor_id', 'number_of_spaces')
        .joins(:parking_transactions)
        .where('parking_transactions.active = ?', true)
        .group('floor_id, number_of_spaces')
        .having('cnt < number_of_spaces')
        .collect(&:floor_id)
    )
  end
end