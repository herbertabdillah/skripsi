class Course < ApplicationRecord
  belongs_to :department
  enum kind: { class: 'class', activity: 'activity' }
end
