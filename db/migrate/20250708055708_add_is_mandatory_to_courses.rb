class AddIsMandatoryToCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :courses, :is_mandatory, :boolean, default: false
  end
end
