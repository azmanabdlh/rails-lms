class CreateAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :answers do |t|
      t.belongs_to :exam, null: false, foreign_key: true
      t.belongs_to :submission, null: false, foreign_key: true
      t.string :option_key, null: true
      t.boolean :is_answered, default: false

      t.timestamps
    end
  end
end
