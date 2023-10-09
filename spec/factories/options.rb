FactoryBot.define do
  factory :option do
    sequence(:code) { |n| "#{n}" }
    sequence(:name) { |n| "選択肢#{n}" }
  end
end
