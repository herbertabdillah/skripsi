ActiveAdmin.register Lecturer do
  menu parent: 'Manage Users', if: proc{ current_user.is_admin? }
  permit_params :name, :nik
end
