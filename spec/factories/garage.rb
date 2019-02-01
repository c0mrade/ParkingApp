FactoryBot.define do
  factory :garage do
    sequence(:name) { |n| "some_name_#{n}" }
    ignore do
      floors_count 1
    end
    after(:build) do |garage, evaluator|
      garage.floors << FactoryBot.build_list(
        :floor,
        evaluator.floors_count,
        garage: nil
      )
    end
  end
end