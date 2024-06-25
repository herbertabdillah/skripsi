
class Api::CoursePlansController < ActionController::Base
  def show
    # @course_plan = CoursePlan.includes(:course_result).find(params[:id])
    @course_plan = CoursePlan.includes(:choose_courses).find(params[:id])
    render json: @course_plan
  end
end