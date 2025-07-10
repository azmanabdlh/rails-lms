class CreateExams < ActiveRecord::Migration[8.0]
  def change
    create_table :exams do |t|
      t.string :question_text
      t.text :body, null: true
      t.belongs_to :course, null: false, foreign_key: true
      t.text :options, default: "[]"
      # {
      #   "key": "32323489",
      #   "textPlain": "blablabla"
      #   "textPlainHTML": "<p>blabla</p>",
      #   "correct": true
      # }
      t.integer :points, default: 0

      t.timestamps
    end
  end
end
