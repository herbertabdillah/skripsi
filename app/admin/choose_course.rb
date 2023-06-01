ActiveAdmin.register CourseSemester, as: 'Choose Course' do
  # scope('all', default: true) { |scope| scope.where("1=1") }

  # menu false

  belongs_to :course_plan

  batch_action :add do |ids|
    cp = CoursePlan.find params[:course_plan_id]

    cpcs = ids.map do |id|
      CoursePlanCourseSemester.create(course_semester_id: id, course_plan: cp)
    end

    redirect_to admin_course_plan_path(id: cp.id), notice: "The posts have been flagged."
  end

  permit_params :year, :semester, :course_id, :lecturer_id
  controller do
    def scoped_collection
      super
      CourseSemester.where.not(id: @course_plan.course_plan_course_semesters.pluck(:course_semester_id))
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
