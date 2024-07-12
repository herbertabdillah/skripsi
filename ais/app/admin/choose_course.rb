ActiveAdmin.register CourseSemester, as: 'Choose Course' do
  # scope('all', default: true) { |scope| scope.where("1=1") }

  # menu false

  belongs_to :course_plan

  def insert_course(course_semester_ids)
    cp = CoursePlan.find params[:course_plan_id]
    existing_total_credit = CoursePlan.includes(course_plan_course_semesters: :course_semester).find(4).course_plan_course_semesters.map { |x| x.course_semester.course }.sum { |x| x.credit }

    course_semester_ids.map do |id|
      course = CourseSemester.find(id).course
      if existing_total_credit + course.credit > 24
        raise StandardError
      end
    end

    course_semester_ids.map do |id|
      CoursePlanCourseSemester.create(course_semester_id: id, course_plan: cp)
    end
  end

  # batch_action :add do |ids|
  #   cp = CoursePlan.find params[:course_plan_id]

  #   cpcs = ids.map do |id|
  #     CoursePlanCourseSemester.create(course_semester_id: id, course_plan: cp)
  #   end

  #   redirect_to admin_course_plan_path(id: cp.id), notice: "The posts have been flagged."
  # end

  batch_action :add do |ids|
    cp = CoursePlan.find params[:course_plan_id]
    begin
      insert_course(ids)
      # redirect_to admin_course_plan_path(id: cp.id), notice: "Success add course"
      redirect_to admin_course_plan_path(id: cp.id), flash: { success: "Success add course" }
    rescue
      # redirect_to admin_course_plan_path(id: cp.id), error: "Total credit can't exceed 24"
      redirect_to admin_course_plan_path(id: cp.id), flash: { error: "Total credit can't exceed 24" }
    end
  end


  permit_params :year, :semester, :course_id, :lecturer_id
  controller do
    def scoped_collection
      super
      current_course_year = CourseYear.where(year: ApplicationConfig.find_by_key('year').value.to_i, semester: ApplicationConfig.find_by_key('semester').value.to_i).first
      CourseSemester.where(year: current_course_year.year, semester: current_course_year.semester).where.not(id: @course_plan.course_plan_course_semesters.pluck(:course_semester_id))
    end

    def destroy
      cp = CoursePlan.find params[:course_plan_id]
      cs = CourseSemester.find params[:id]

      # cp.course_plan_course_semesters.delete()
      cp.course_plan_course_semesters.where(course_semester: cs).delete_all

      redirect_to admin_course_plan_path(id: cp.id), alert: "The posts have been flagged."
    end
  end

end
