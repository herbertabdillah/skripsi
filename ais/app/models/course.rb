class Course < ApplicationRecord
  has_many :blockchain_syncs, as: :syncable
  belongs_to :department
  enum kind: { class: 'class', activity: 'activity' }
end
