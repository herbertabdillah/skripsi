ActiveAdmin.register_page "Manage Users" do
  menu label: 'Manage Users', if: proc{ current_user.is_admin? }
end
