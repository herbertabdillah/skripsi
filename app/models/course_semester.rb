class CourseSemester < ApplicationRecord
  belongs_to :course
  belongs_to :lecturer
  has_many :course_plan_course_semesters
  has_many :course_result_scores, through: :course_plan_course_semesters
end
