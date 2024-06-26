# class SyncJob < ApplicationJob
class SyncJob
  include Sidekiq::Job
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
  def perform(id)
    last_bs = BlockchainSync.last
    bsb = BlockchainSyncBatch.find(id)
    s = FabricSync::Sync.new(bsb)
    if last_bs.blank?
      s.run start_date: 1.year.ago
    else
      s.run start_date: last_bs.created_at
    end
    
    bsb.status = :success
    bsb.save
  end
end
