class Student < ApplicationRecord
  attr_accessor :email
  belongs_to :department
  belongs_to :supervisor_lecturer, class_name: "Lecturer"
  has_one :user, as: :userable
  enum status: { active: 'active', non_active: 'non_active', graduated: 'graduated', drop_out: 'drop_out' }
end
