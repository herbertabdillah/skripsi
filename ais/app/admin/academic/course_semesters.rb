ActiveAdmin.register CourseSemester do
  menu parent: 'Academic', if: proc{ current_user.is_admin? }
  permit_params :year, :semester, :course_id, :lecturer_id

  form do |f|
    f.object.year ||= CourseYear.active.year
    f.object.semester ||= CourseYear.active.semester_int
    f.inputs do
      f.input :course
      f.input :lecturer
      f.input :year
      f.input :semester
    end
    f.actions
  end
end
