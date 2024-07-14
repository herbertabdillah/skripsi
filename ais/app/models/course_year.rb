class CourseYear < ApplicationRecord
  enum semester: {odd: 'odd', even: 'even' }
  def self.active
    CourseYear.last
  end

  def self.create_from_semester_int(year:, semester:)
    semester_word = "odd"
    if semester == 2
      semester_word = "even"
    end
    CourseYear.create(year: year, semester: semester_word)
  end

  def semester_int
    if even?
      return 2
    else
      return 1
    end
  end
end
