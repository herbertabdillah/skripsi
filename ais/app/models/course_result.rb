class CourseResult < ApplicationRecord
  belongs_to :course_plan
  has_many :course_result_scores

  def get_transcript
    total_credit = 0
    total_score = 0
    CourseResult
      .includes(course_result_scores: {course_plan_course_semester: {course_semester: :course}})
      .where(id: id).first
      .course_result_scores
      .each do |crs|
        credit = crs.course_plan_course_semester.course_semester.course.credit
        score = crs.score

        total_credit = total_credit + credit
        total_score = total_score + score * credit
      end
    
    {
      total_credit: total_credit,
      score: total_score * 1.0 / total_credit
    }
  end
end
