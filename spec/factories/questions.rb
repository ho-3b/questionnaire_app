FactoryBot.define do
  factory :question do
    questionnaire { nil }
    title { "MyString" }
    section_id { 1 }
    body { "MyText" }
    answer_type_id { 1 }
  end
end
