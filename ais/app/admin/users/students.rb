ActiveAdmin.register Student do
  menu parent: 'Manage Users', if: proc{ current_user.is_admin? }
  permit_params :name, :nim, :department_id, :entry_year, :status, :supervisor_lecturer_id, :email

  form do |f|
    f.inputs do
      f.input :name
      f.input :nim
      f.input :department
      f.input :entry_year
      f.input :status, as: :select, collection: Student.statuses.keys
      f.input :supervisor_lecturer
      f.input :email
    end
    f.actions
  end

  controller do
    def create
      create! do |format|
        # binding.pry
        User.create!(email: params[:student][:email], password: 'password', password_confirmation: 'password', userable_type: 'Student', userable_id: @student.id)
        format.html { redirect_to admin_student_path(id: @student.id) }
      end
      # student = Student.find params[:graduate][:student_id]
      # graduate_service = GraduateService.new(student)
      # graduate_service.graduate
# 
      # redirect_to admin_graduates_path, notice: "graduated"
    # rescue
      # redirect_to admin_graduates_path, alert: "havent done all course"
    end
  end
end
