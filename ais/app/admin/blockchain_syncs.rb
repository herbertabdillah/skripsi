ActiveAdmin.register BlockchainSync do
  menu label: 'Batch Item', parent: 'blockchain_sync_batches', if: proc{ current_user.is_admin? }
  # belongs_to :blockchain_sync_batch
  permit_params :syncable_type, :syncable_id, :status, :description
  filter :syncable_type
  filter :syncable_id
  filter :status, as: :select, collection: BlockchainSync.statuses
  filter :description
  filter :created_at

  index do
    column :id
    column :syncable
    # column :syncable_type
    column :status
    column :description do |x|
      x.description&.truncate(80)
    end
    column :updated_at
    column :blockchain_sync_batch
    actions
  end

end
