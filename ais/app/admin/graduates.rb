ActiveAdmin.register Graduate do
  menu if: proc{ current_user.lecturer_or_admin? }

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
  controller do
    def create
      student = Student.find params[:graduate][:student_id]
      graduate_service = GraduateService.new(student)
      graduate_service.graduate

      redirect_to admin_graduates_path, notice: "graduated"
    rescue
      redirect_to admin_graduates_path, alert: "havent done all course"
    end
  end
end
