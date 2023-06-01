class CreateCourseResultScores < ActiveRecord::Migration[6.1]
  def change
    create_table :course_result_scores do |t|
      t.references :course_result, null: false, foreign_key: true
      t.references :course_plan_course_semester, null: false, foreign_key: true
      t.decimal :score

      t.timestamps
    end
  end
end
