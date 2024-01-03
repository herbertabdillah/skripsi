class BlockchainSyncBatch < ApplicationRecord
	enum status: { created: 'created', running: 'running', success: 'success', failed: 'failed' }
  after_initialize :default_values
  after_create :sync_job
  has_many :blockchain_syncs

  private

  def default_values
    status = :created
  end

  def sync_job
    SyncJob.perform_later(id)
  end
end
