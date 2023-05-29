class Student < ApplicationRecord
  belongs_to :department
  belongs_to :supervisor_lecturer, class_name: "Lecturer"
  enum status: { active: 'active', non_active: 'non_active', drop_out: 'drop_out' }
end
