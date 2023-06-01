ActiveAdmin.register_page "Master data" do
  menu label: 'Master data', if: proc{ current_user.is_admin? }
end
