ActiveAdmin.register Grade do
  belongs_to :student

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :graduated, :student_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:graduated, :student_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  controller do
    def create
      s = FabricSync::SyncGrade.new
      a = params[:grade]
      graduated = a[:graduated] == "1" ? true : false
      student = Student.find(params['student_id'])
      absence_count = student.attendances.where(attended: false).count

      if absence_count > 3 && graduated
        redirect_to new_admin_student_grade_path(student_id: student.id), flash: {error: 'Absence count is > 3, must be not graduated'}
      else
        s.add_grade a[:student_id], graduated
        super
      end


      # super
      # byebug
    end
  end
end
