class CourseResultScore < ApplicationRecord
  belongs_to :course_result
  delegate :course_semester, to: :course_plan_course_semester
  delegate :student, to: :course_plan_course_semester
  belongs_to :course_plan_course_semester

  def lecturer_course
    course_semester
  end
end
