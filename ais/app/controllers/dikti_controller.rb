class DiktiController < ApplicationController
  def index
    if params[:id].present?
      @student = Student.find(params[:id])
      s = FabricSync::SyncGrade.new
      begin
        @grade = s.get_grade(@student.id)
      rescue
        @grade = nil
      end
    else
      @student = nil
    end
  end
end
