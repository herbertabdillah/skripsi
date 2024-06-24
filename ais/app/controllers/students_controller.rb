class StudentsController < ApplicationController
  def index
    @students = Student.all
    render json: @students
  end

  def create
    @student = Student.new(params.permit(:name, :nim, :department_id, :entry_year, :status, :supervisor_lecturer_id))
    @student.save
  end
end