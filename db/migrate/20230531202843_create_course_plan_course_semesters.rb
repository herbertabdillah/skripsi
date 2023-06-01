class CreateCoursePlanCourseSemesters < ActiveRecord::Migration[6.1]
  def change
    create_table :course_plan_course_semesters do |t|
      t.references :course_plan, null: false, foreign_key: true
      t.references :course_semester, null: false, foreign_key: true

      t.timestamps
    end
  end
end
