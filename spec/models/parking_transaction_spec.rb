require 'rails_helper'

describe ParkingTransaction, type: :model do
  describe 'validations' do
    let(:parking_transaction) { FactoryBot.create(:parking_transaction) }

    it 'generates ticket' do
      expect(parking_transaction).not_to be_nil
    end

    context 'garage at single spot left' do
      # Default garage capacity in factorybot factory is 5
      # plus one we created above
      let!(:parking_transactions) do
        FactoryBot.create_list(:parking_transaction, 3, floor: parking_transaction.floor)
      end

      it 'allows for creation of one more parking_transaction' do
        expect { FactoryBot.create(:parking_transaction, floor: parking_transaction.floor) }
          .not_to raise_error
      end
    end

    context 'no parking spots left on single floor' do
      let!(:parking_transactions) do
        FactoryBot.create_list(:parking_transaction, 4, floor: parking_transaction.floor)
      end
      let(:new_parking_transaction) { FactoryBot.build(:parking_transaction, floor: parking_transaction.floor) }

      before do
        new_parking_transaction.save
      end

      it 'model contains errors about garage being full' do
        expect(new_parking_transaction.errors.full_messages).to eq(['Garage is full'])
      end
    end

    context 'no parking spots left on two floors' do
      # first floor is full
      let!(:parking_transactions) do
        FactoryBot.create_list(:parking_transaction, 4, floor: parking_transaction.floor)
      end
      # with 3 parking spots, all occupied
      let(:second_floor) do
        FactoryBot.create(:floor, garage: parking_transaction.floor.garage, number_of_spaces: 3)
      end
      let(:second_floor_occupied_parking) do
        FactoryBot.create_list(:parking_transaction, 3, floor: second_floor)
      end
      let(:new_parking_transaction) { FactoryBot.build(:parking_transaction, floor: parking_transaction.floor) }

      before do
        new_parking_transaction.save
      end

      it 'model contains errors about garage being full' do
        expect(new_parking_transaction.errors.full_messages).to eq(['Garage is full'])
      end
    end
  end
end