ActiveAdmin.register CourseYear do
  menu label: 'Course Year', parent: 'Academic', if: proc{ current_user.is_admin? }

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :year, :semester, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:year, :semester, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.inputs do
      f.input :year
      f.input :semester, as: :select, collection: CourseYear.semesters.keys
      # f.input :status
    end
    f.actions
  end
end
