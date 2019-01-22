require 'rails_helper'

describe Floor, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:garage).required(true) }
    it { is_expected.to have_many :parking_transactions }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :number_of_spaces }
  end

  describe '.capacity' do
    let(:garage) { FactoryBot.create(:garage) }
    let!(:floors) { FactoryBot.create_list(:floor, 2, number_of_spaces: 3, garage: garage) }
    it 'returns 6 as the garage capacity' do
      expect(garage.capacity).to eq(6)
    end
  end
end