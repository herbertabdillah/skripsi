class Faculty < ApplicationRecord
    has_many :blockchain_syncs, as: :syncable
end
