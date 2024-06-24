class Department < ApplicationRecord
  has_many :blockchain_syncs, as: :syncable
  belongs_to :faculty
end
