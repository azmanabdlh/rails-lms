class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :body
      t.string :slug
      t.string :thumbnail_url
      t.integer :duration
      t.integer :min_score, default: false
      t.boolean :is_randomize, default: false
      t.boolean :is_active, default: true

      t.belongs_to :user
      t.bigint :parent_id
      t.datetime :started_at, null: true
      t.datetime :ended_at, null: true

      t.timestamps
    end
  end
end
