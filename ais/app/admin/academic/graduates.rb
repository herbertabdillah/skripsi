ActiveAdmin.register Graduate do
  menu parent: 'Academic', if: proc{ current_user.lecturer_or_admin? }

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :student_id, :score, :year
  #
  # or
  #
  # permit_params do
  #   permitted = [:student_id, :score, :year]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.inputs "Graduate" do
      f.input :student
      f.input :year, :input_html => { value: CourseYear.active.year }
    end
    f.actions
  end
  controller do
    def create
      student = Student.find params[:graduate][:student_id]
      graduate_service = GraduateService.new(student)
      graduate_service.graduate

      redirect_to admin_graduates_path, flash: { success: "graduated" }
    rescue
      flash[:error] = "havent done all course"
      redirect_to admin_graduates_path, flash: { error: "havent done all course" }
      # render :create
      # redirect_to admin_graduates_path, alert: "havent done all course"
      # redirect_to admin_course_plan_path(id: cp.id), flash: { error: "Total credit can't exceed 24" }
    end
  end
end
