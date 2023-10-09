FactoryBot.define do
  factory :administrator do
    email { 'user1@example.com' }
  end

  factory :administrator_with_password, class: Administrator do
    email { 'user1@example.com' }
    password { 'Xb5-+.Fm' }
  end
end
