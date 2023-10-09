class Questionnaire < ApplicationRecord
  PUBLIC = 1
  PRIVATE = 2

  belongs_to :administrator

  has_many :questions
  has_many :sections

  accepts_nested_attributes_for :questions
  accepts_nested_attributes_for :sections

  validates :title, presence: true


end
