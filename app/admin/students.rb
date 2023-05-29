ActiveAdmin.register Student do
  menu parent: 'Users'
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
end
