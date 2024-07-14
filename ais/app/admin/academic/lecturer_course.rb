ActiveAdmin.register CourseSemester, as: 'Lecturer Course' do
  menu parent: 'Academic', if: proc{ current_user.lecturer? }
  permit_params :year, :semester, :course_id, :lecturer_id

  show do |course_semester|
    resource
    attributes_table do
      row(:course) { course_semester.course.name }
      row :year
      row :semester
    end

    panel 'Student Taken' do
      # div class: 'action_item', style: 'float: left' do
      #   button_to 'Choose Course', admin_course_plan_choose_courses_path(course_plan_id: course_plan.id), method: :get
      # end

      div style: 'clear: both;'

      counter = 0

      table_for course_semester.course_result_scores do
        column(:no) { counter += 1 }
        column(:name) { |c| c.student.name }
        column(:score) { |c| c.score }
        column(:actions) do |c|
          link_to "Edit", edit_admin_lecturer_course_course_result_score_path(lecturer_course_id: c.course_semester.id, id: c.id)
        end
      end
    end
  end

  controller do
    def scoped_collection
      return super if current_user.is_admin?

      super.where(lecturer: current_user.userable)
    end
  end
end
