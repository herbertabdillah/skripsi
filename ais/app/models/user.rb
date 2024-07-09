class User < ApplicationRecord
  belongs_to :userable, polymorphic: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  def student?
    userable.is_a? Student
  end

  def lecturer?
    userable.is_a?(Lecturer) && !is_admin?
  end

  def lecturer_or_admin?
    lecturer? || is_admin?
  end
end
