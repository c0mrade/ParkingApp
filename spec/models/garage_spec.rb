require 'rails_helper'

describe Garage, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :floors }
    it { is_expected.to have_many :parking_transactions }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe '.capacity' do
    let(:garage) { FactoryBot.create(:garage) }
    let!(:floors) { FactoryBot.create_list(:floor, 2, number_of_spaces: 3, garage: garage) }
    it 'returns 6 as the garage capacity' do
      expect(garage.capacity).to eq(6)
    end
  end

  describe 'deleting garage with active prking' do
    let(:garage) { FactoryBot.create(:garage) }
    let(:floor) { FactoryBot.create(:floor, number_of_spaces: 1, garage: garage) }

    context 'Garage has active parking' do
      before do
        FactoryBot.create(:parking_transaction, floor: floor)
        garage.destroy
      end

      it 'garage not destroyed' do
        expect(garage.destroyed?).not_to be_truthy
      end
    end

    context 'Garage has no active parking' do
      it 'garage not destroyed' do
        garage.destroy
        expect(garage.destroyed?).to be_truthy
      end
    end
  end
end

