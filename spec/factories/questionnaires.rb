FactoryBot.define do
  factory :questionnaire do
    administrator_id { 1 }
    title { "アンケートタイトル" }
    status_id { Questionnaire::PRIVATE }
    terminates_at { "2023-10-31 23:59:59" }
  end
end
