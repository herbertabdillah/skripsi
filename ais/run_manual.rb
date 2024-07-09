last_bs = BlockchainSync.last
bsb = BlockchainSyncBatch.find 1
s = FabricSync::Sync.new(bsb)
s.run start_date: last_bs.created_at