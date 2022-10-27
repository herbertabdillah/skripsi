class Student < ApplicationRecord
  has_many :attendances
  has_many :grades
end
