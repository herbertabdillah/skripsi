class CreateCourseResults < ActiveRecord::Migration[6.1]
  def change
    create_table :course_results do |t|
      t.references :course_plan, null: false, foreign_key: true
      t.decimal :score

      t.timestamps
    end
  end
end
