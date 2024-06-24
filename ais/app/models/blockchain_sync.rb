class BlockchainSync < ApplicationRecord
    belongs_to :syncable, polymorphic: true
    belongs_to :blockchain_sync_batch

    enum status: { success: 'success', error: 'error', resolved: 'resolved' }
end
