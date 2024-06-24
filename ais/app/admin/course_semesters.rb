ActiveAdmin.register CourseSemester do
  menu if: proc{ current_user.is_admin? }
  permit_params :year, :semester, :course_id, :lecturer_id
end
