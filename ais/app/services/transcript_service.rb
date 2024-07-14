class TranscriptService
  def initialize(student)
    @student = student
    @total_credit = 0
    @taken_course_ids = []
    @department_course_ids = []

    process_transcript
  end

  def have_done_all_course?
    @taken_course_ids.sort == @department_course_ids.sort
    # binding.pry
  end

  def cumulative_score
    @cumulative_score
  end

  def total_credit
    @total_credit
  end

  def process_transcript
    @department_course_ids = Course.where(department: @student.department).pluck(:id)
    query = <<-SQL
      select sum(score) as sum, sum(credit) as credit from (
        select max(crs.score) * max(c.credit) score, max(c.credit) as credit
        from course_result_scores crs
        inner join course_results cr on cr.id=crs.course_result_id
        inner join course_plans cp on cp.id = cr.course_plan_id
        inner join course_plan_course_semesters cpcs on cpcs.id = crs.course_plan_course_semester_id
        inner join course_semesters cs on cs.id = cpcs.course_semester_id
        inner join courses c on c.id = cs.course_id
        where cp.student_id = #{@student.id}
        group by cs.course_id
      ) score    
    SQL
    scores = ActiveRecord::Base.connection.execute query

    @total_credit = scores.first["credit"]
    @cumulative_score = scores.first["sum"] / scores.first["credit"]

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

    @taken_course_ids = ids.pluck("course_id")
  end
end