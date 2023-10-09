class CreateOptionGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :option_groups do |t|
      t.references :questionnaire, null: false, foreign_key: true

      t.timestamps
    end
  end
end
