ActiveAdmin.register CourseResultScore do
  # belongs_to :lecturer_course, parent_class: CourseSemester

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :course_result_id, :course_plan_course_semester_id, :score
  #
  # or
  #
  # permit_params do
  #   permitted = [:course_result_id, :course_plan_course_semester_id, :score]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  controller do
    def update
      update! do |format|
        format.html { redirect_to admin_lecturer_course_path(id: @lecturer_course.id) }
      end
    end
  end
end
