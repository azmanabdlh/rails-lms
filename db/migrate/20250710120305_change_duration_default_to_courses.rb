class ChangeDurationDefaultToCourses < ActiveRecord::Migration[8.0]
  def change
    change_column_default :courses, :duration, 0
  end
end
