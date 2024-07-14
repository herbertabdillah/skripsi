class CoursePlan < ApplicationRecord
  belongs_to :student
  has_many :course_plan_course_semesters
  has_many :choose_courses, through: :course_plan_course_semesters, source: :course_semester
  has_one :course_result

  accepts_nested_attributes_for :course_plan_course_semesters, :allow_destroy => true
  def get_total_credit
    total_credit = 0
    total_score = 0
    CoursePlan
      .includes(course_plan_course_semesters: {course_semester: :course})
      .where(id: id).first
      .course_plan_course_semesters
      .each do |cpcs|
        credit = cpcs.course_semester.course.credit

        total_credit = total_credit + credit
      end
    
    total_credit
  end

end
