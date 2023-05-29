ActiveAdmin.register Department do
  menu parent: 'Master data'
  permit_params :faculty_id, :name
end
