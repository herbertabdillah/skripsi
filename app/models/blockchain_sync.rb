class BlockchainSync < ApplicationRecord
    belongs_to :syncable, polymorphic: true
end
