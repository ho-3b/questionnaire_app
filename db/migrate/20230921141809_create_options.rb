class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.references :questionnaire
      t.references :option_group
      t.string :code
      t.string :name, null: false
      # その他（具体的に）タイプの選択肢
      t.boolean :other_flg, null:false, default: false

      t.timestamps
    end
  end
end
