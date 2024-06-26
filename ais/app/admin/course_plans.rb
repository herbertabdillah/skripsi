ActiveAdmin.register CoursePlan do
  permit_params :year, :semester, :student_id, :is_approved

  form do |f|
    f.inputs "Course Plan" do
      f.input :year, :input_html => { value: ApplicationConfig.get('year') }
      f.input :semester, :input_html => { value: ApplicationConfig.get('semester') }
      if current_user.lecturer_or_admin?
        f.input :student, :input_html => { disabled: true }
        f.input :is_approved
      end
    end
    f.actions
  end

  show do |course_plan|

    if current_user.lecturer?
      div class: 'action_item' do
        button_to 'Approve Plan', approve_admin_course_plan_path(id: course_plan.id), method: :post
      end
    end

    attributes_table do
      row :year
      row :semester
      row :student
      row :is_approved
    end

    panel 'Course Taken' do
      div class: 'action_item', style: 'float: left' do
        button_to 'Choose Course', admin_course_plan_choose_courses_path(course_plan_id: course_plan.id), method: :get
      end

      div style: 'clear: both;'

      counter = 0

      table_for course_plan.course_plan_course_semesters do
        column(:no) { counter += 1 }
        column(:name) { |c| c.course_semester.course.name }
        column(:lecturer) { |c| c.course_semester.lecturer.name }
        column(:credit) { |c| c.course_semester.course.credit }
        column :actions do |cpcs|
          link_to "Delete", admin_course_plan_choose_course_path(course_plan_id: cpcs.course_plan.id, id: cpcs.course_semester_id), method: :delete
        end
      end
    end
  end

  member_action :approve, method: :post do
    CoursePlanService.new(resource).submit
    redirect_to admin_course_plan_path
  end

  controller do
    def scoped_collection
      if current_user.is_admin?
        super
      elsif current_user.lecturer?
        super.includes(:student).where(student: {supervisor_lecturer: current_user.userable})
      elsif current_user.student? 
        super.where(student: current_user.userable)
      else
        super
      end
    end
  end
end
