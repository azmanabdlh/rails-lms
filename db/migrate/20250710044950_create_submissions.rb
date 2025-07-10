class CreateSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions do |t|
      t.belongs_to :course, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :started_at
      t.boolean :is_completed, default: false
      t.datetime :submitted_at, null: true

      t.timestamps
    end
  end
end
