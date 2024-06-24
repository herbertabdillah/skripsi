class CourseResult < ApplicationRecord
  belongs_to :course_plan
  has_many :course_result_scores
end
