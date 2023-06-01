class CoursePlanCourseSemester < ApplicationRecord
  belongs_to :course_plan
  belongs_to :course_semester
  has_one :course_result_score
  delegate :student, to: :course_plan
end
