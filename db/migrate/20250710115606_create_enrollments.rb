class CreateEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollments do |t|
      t.belongs_to :course, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
