class CreateQuestionnaires < ActiveRecord::Migration[7.0]
  def change
    create_table :questionnaires do |t|
      t.references :administrator, null: false, foreign_key: true
      t.string :title, null:false
      t.integer :status_id, null: false, default: Questionnaire::PRIVATE
      t.datetime :terminates_at

      t.timestamps
    end
  end
end
