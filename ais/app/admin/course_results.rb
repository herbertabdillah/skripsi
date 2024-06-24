ActiveAdmin.register CourseResult do
  menu if: proc{ current_user.student? }

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :course_plan_id, :score
  #
  # or
  #
  # permit_params do
  #   permitted = [:course_plan_id, :score]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  show do |course_result|
    attributes_table do
      row :score
      row(:semester) { |c| c.course_plan.semester }
      row(:year) { |c| c.course_plan.year }
    end

    panel 'Course Taken' do
      div class: 'action_item', style: 'float: left' do
        button_to 'Choose Course', admin_course_plan_choose_courses_path(course_plan_id: course_result.course_plan.id), method: :get
      end

      div style: 'clear: both;'

      counter = 0

      table_for course_result.course_result_scores do
        # course_semester = crs.course_plan_course_semester.course_semester

        column(:no) { counter += 1 }
        column(:name) { |crs| crs.course_semester.course.name }
        column(:lecturer) { |crs| crs.course_semester.lecturer.name }
        column(:credit) { |crs| crs.course_semester.course.credit }
        column(:score)
        # column :actions do |cpcs|
        #   link_to "Delete", admin_course_plan_choose_course_path(course_plan_id: cpcs.course_plan.id, id: cpcs.course_semester_id), method: :delete
        # end
      end
    end
  end 
end
