require 'securerandom'

class Api::DepartmentsController < ActionController::Base
  skip_forgery_protection

  def create
    department = Department.create!(name: SecureRandom.uuid, faculty_id: 1)
    head :ok
  end
  def show
    # @course_plan = CoursePlan.includes(:course_result).find(params[:id])
    @department = Department.find(params[:id])
    render json: @department
  end
end