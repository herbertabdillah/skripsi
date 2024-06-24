ActiveAdmin.register Course do
  menu parent: 'Master data'
  permit_params :name, :department_id, :kind, :credit

  form do |f|
    f.inputs do
      f.input :name
      f.input :department
      f.input :kind, as: :select, collection: Course.kinds.keys
      f.input :credit
    end
    f.actions
  end
end
