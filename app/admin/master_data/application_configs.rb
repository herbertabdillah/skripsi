ActiveAdmin.register ApplicationConfig do
  menu parent: 'Master data'
  permit_params :key, :value
end
