ActiveAdmin.register Student, as: 'Lecturer Student' do
  menu parent: 'Manage Users', if: proc{ current_user.lecturer? }
  permit_params :name, :nim, :department_id, :entry_year, :status, :supervisor_lecturer_id

  form do |f|
    f.inputs do
      f.input :name
      f.input :nim
      f.input :department
      f.input :entry_year
      f.input :status, as: :select, collection: Student.statuses.keys
      f.input :supervisor_lecturer
    end
    f.actions
  end

  controller do
    def scoped_collection
      return super if current_user.is_admin?

      super.where(supervisor_lecturer: current_user.userable)
    end
  end
end
