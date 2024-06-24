class CoursePlanService
  def initialize(course_plan)
    @course_plan = course_plan
  end

  def submit
    ActiveRecord::Base.transaction do
      @course_plan.is_approved = true
      @course_plan.save

      course_result = CourseResult.create course_plan: @course_plan

      @course_plan.course_plan_course_semesters.each do |cpcs|
        CourseResultScore.create course_result: course_result, course_plan_course_semester: cpcs
      end
    end
  end
end