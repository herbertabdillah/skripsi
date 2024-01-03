class SyncJob < ApplicationJob
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
  def perform(id)
    last_bs = BlockchainSync.last
    bsb = BlockchainSyncBatch.find(id)
    s = FabricSync::Sync.new(bsb)
    s.run start_date: last_bs.created_at
    
    bsb.status = :success
    bsb.save
  end
end
