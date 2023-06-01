class CreateCoursePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :course_plans do |t|
      t.integer :year
      t.integer :semester
      t.references :student, null: false, foreign_key: true
      t.boolean :is_approved

      t.timestamps
    end
  end
end
