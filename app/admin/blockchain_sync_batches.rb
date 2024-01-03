ActiveAdmin.register BlockchainSyncBatch do
  menu label: 'PDDIKTI Sync', if: proc{ current_user.is_admin? }

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :description

  form do |f|
    f.inputs do
      f.input :description
    end
    f.actions
  end

  show do |bsb|
    attributes_table do
      row :description
      row :status
      row :sync_result
      row :created_at
    end

    panel 'Data' do
      table_for bsb.blockchain_syncs do
        column :id
        column :syncable_type
        column :syncable
        column :status
        column :description
      end
    end
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:syncable_type, :syncable_id, :status, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
