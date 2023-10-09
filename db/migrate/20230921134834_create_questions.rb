class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :questionnaire, null: false, foreign_key: true
      t.integer :section_id
      t.text :body, null: false
      t.integer :answer_type_id, null: false
      t.integer :required_type_id, null: false
      t.integer :min_number
      t.integer :max_number

      # 選択肢（独自）の場合
      t.integer :option_group_id

      t.timestamps
    end
  end
end
