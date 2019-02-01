require 'rails_helper'

describe Floor, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:garage).required(true) }
    it { is_expected.to have_many :parking_transactions }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :number_of_spaces }

    context 'floor needs to be vacated before destroying' do
      let(:floor) { FactoryBot.create(:floor) }

      context 'Partially filled floor' do
        let!(:parking_transactions) { FactoryBot.create_list(:parking_transaction, 2, floor: floor) }

        it 'destroy method returns false indicating record is not destroyed' do
          expect(floor.destroy).to be_falsy
        end
      end

      context 'Empty floor' do
        it 'destroy method returns true indicating record is destroyed' do
          expect(floor.destroy).to be_truthy
        end
      end
    end
  end
end