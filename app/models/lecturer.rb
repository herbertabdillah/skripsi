class Lecturer < ApplicationRecord
  has_one :user, as: :userable
end
