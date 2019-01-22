FactoryBot.define do
  factory :garage do
    sequence(:name) { |n| "some_name_#{n}" }
  end
end