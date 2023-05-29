ActiveAdmin.register Lecturer do
  menu parent: 'Users'
  permit_params :name, :nik
end
