ActiveAdmin.register Student do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  show do |student|
    attributes_table do
      row :id
      row :name
    end
    # panel 'Grade' do
    # end

    panel 'Grade' do
      # binding.pry
      # byebug
      div class: 'action_item' do
        button_to 'Add Grade', new_admin_student_grade_path(student_id: student.id), method: :get
      end
      if student.grades.count > 0
        attributes_table_for student.grades[0] do
          row :graduated
        end
      end
      # table_for student.grades do
      #   column :graduated
      # end
    end
    panel 'Attendance' do
      # binding.pry
      # byebug
      div class: 'action_item' do
        button_to 'Add Attendance', new_admin_student_attendance_path(student_id: student.id), method: :get
      end
      table_for student.attendances do
        column :week_number
        column :attended
      end
    end
  end
  
end
