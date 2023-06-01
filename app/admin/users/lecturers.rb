ActiveAdmin.register Lecturer do
  menu parent: 'Manage Users'
  permit_params :name, :nik
end
