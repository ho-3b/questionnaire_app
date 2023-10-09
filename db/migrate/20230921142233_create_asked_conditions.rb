class CreateAskedConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :asked_conditions do |t|
      t.references :target, null: false, polymorphic: true
      t.integer :trigger_question_id, null: false
      t.string :trigger_answer_ids
      t.timestamps
    end
  end
end
