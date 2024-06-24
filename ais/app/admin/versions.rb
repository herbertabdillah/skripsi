ActiveAdmin.register PaperTrail::Version do
  menu label: 'Audit Log', if: proc{ current_user.is_admin? }

  config.filters = true
  actions :index

  index do
    column :item_type
    column :item_id
    column :event
    column :email
    column :object do |version|
      pre class: 'code_container' do
        JSON.pretty_generate version.object
      end
    end
    column :object_changes do |version|
      pre class: 'code_container' do
        JSON.pretty_generate version.object_changes
      end
    end
    column :created_at
  end

  csv do
    column :item_type
    column :item_id
    column :event
    column :email
    column :object
    column :object_changes
    column :created_at
  end

  filter :item_type
  filter :item_id
end
