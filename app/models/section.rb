class Section < ApplicationRecord
  belongs_to :questionnaire
  has_many :questions

  has_many :asked_conditions, :as => :target

  accepts_nested_attributes_for :questions
  accepts_nested_attributes_for :asked_conditions
end
