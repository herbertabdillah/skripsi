class CoursePlan < ApplicationRecord
  belongs_to :student
  has_many :course_plan_course_semesters
  has_many :choose_courses, through: :course_plan_course_semesters, source: :course_semester
  has_one :course_result

  accepts_nested_attributes_for :course_plan_course_semesters, :allow_destroy => true
end
