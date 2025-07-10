class ChangeParentIdDefaultToCourses < ActiveRecord::Migration[8.0]
  def change
    change_column_default :courses, :parent_id, 0
  end
end
