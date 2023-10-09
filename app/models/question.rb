class Question < ApplicationRecord
  # 回答タイプ
  FREE_STR = 1 # 自由記述（255字以内）
  FREE_TEXT = 2 # 自由記述（テキスト）
  SINGLE_SELECT = 3 # 1つ選択
  MULTI_SELECT = 4 # 複数選択
  NUMERIC = 5 # 数字

  ANSWER_TYPE_LIST = {
    FREE_STR => '自由記述（255字以内）',
    FREE_TEXT => '自由記述（テキスト）',
    SINGLE_SELECT => '1つ選択',
    MULTI_SELECT => '複数選択',
    NUMERIC => '数字',
  }


  belongs_to :questionnaire
  belongs_to :section, optional: true

  has_many :options
  has_many :asked_conditions, :as => :target

  accepts_nested_attributes_for :options
  accepts_nested_attributes_for :asked_conditions


end
