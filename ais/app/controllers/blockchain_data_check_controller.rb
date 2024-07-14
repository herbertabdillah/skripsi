class BlockchainDataCheckController < ApplicationController
  def index
    @error = nil
    if params[:id].present?
      @student = Student.find(params[:id])
      adapter = FabricSync::Adapter.new
      @student_b = adapter.get_student(@student.id)
      @transcript_b = adapter.get_transcript(@student.id)
    else
      @student = nil
    end
  rescue
    @error = "Data tidak ditemukan"
    flash[:alert] = @error
  end
end

# {"id"=>"1",
#  "name"=>"student a",
#  "nim"=>"11170910000548",
#  "department_id"=>"1",
#  "entry_year"=>2017,
#  "status"=>"graduated",
#  "supervisor_lecturer_id"=>"2",
#  "exit_year"=>2020
# }
# {"id"=>"1",
#  "student_id"=>"1",
#  "score"=>3.549019607843137,
#  "array"=>
#   [{"course_result_id"=>"1", "course_id"=>"1", "year"=>2017, "semester"=>"odd", "score"=>3, "pass"=>true},
#    {"course_result_id"=>"1", "course_id"=>"2", "year"=>2017, "semester"=>"odd", "score"=>4, "pass"=>true},
#    {"course_result_id"=>"1", "course_id"=>"3", "year"=>2017, "semester"=>"odd", "score"=>4, "pass"=>true}
#   ]
# }