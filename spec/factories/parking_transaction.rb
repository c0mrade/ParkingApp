FactoryBot.define do
  factory :parking_transaction do
    association :floor, factory: :floor
  end
end