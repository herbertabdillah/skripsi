class TranscriptService
  def initialize(student)
    @student = student
  end

  def have_done_all_course?
    taken_course_ids.sort == department_course_ids.sort
  end

  def cumulative_score
    query = <<-SQL
      select sum(score) from (select max(crs.score) score
      from course_result_scores crs
      inner join course_results cr on cr.id=crs.course_result_id
      inner join course_plans cp on cp.id = cr.course_plan_id
      inner join course_plan_course_semesters cpcs on cpcs.id = crs.course_plan_course_semester_id
      inner join course_semesters cs on cs.id = cpcs.course_semester_id
      where cp.student_id = #{@student.id}
      group by cs.course_id) score    
    SQL
    scores = ActiveRecord::Base.connection.execute query

    scores.first["sum"]
  end

  def taken_course_ids
    query = <<-SQL
      select distinct cs.course_id
      from course_result_scores crs
      inner join course_results cr on cr.id=crs.course_result_id
      inner join course_plans cp on cp.id = cr.course_plan_id
      inner join course_plan_course_semesters cpcs on cpcs.id = crs.course_plan_course_semester_id
      inner join course_semesters cs on cs.id = cpcs.course_semester_id
      where cp.student_id = #{@student.id} and crs.score >= 3
      group by cs.course_id
    SQL
    ids = ActiveRecord::Base.connection.execute query

    ids.pluck("course_id")
  end

  def department_course_ids
    Course.where(department: @student.department).pluck(:id)
  end
end