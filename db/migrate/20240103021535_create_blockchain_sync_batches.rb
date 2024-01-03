class CreateBlockchainSyncBatches < ActiveRecord::Migration[6.1]
  def change
    create_table :blockchain_sync_batches do |t|
      t.string :status
      t.string :description
      t.string :sync_result

      t.timestamps

    end

    add_reference :blockchain_syncs, :blockchain_sync_batch, index: true
  end
end
