class CreateCourseYears < ActiveRecord::Migration[6.1]
  def change
    create_table :course_years do |t|
      t.integer :year
      t.string :semester
      t.string :status

      t.timestamps
    end
  end
end
