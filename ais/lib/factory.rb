class Factory

  def self.create_admin()
    university_domain = "uinjkt.ac.id"

    lecturer_admin = Lecturer.create!(name: "admin", nik: "0")
    user = User.create!(email: "admin@#{university_domain}", password: 'password', password_confirmation: 'password', userable: lecturer_admin, is_admin: true)

    user
  end

  def self.create_lecturer(name)
    university_domain = "uinjkt.ac.id"
    email = name.gsub(/[^0-9a-z ]/i, '').downcase().split(" ").join(".") + "@#{university_domain}"
    nik = "19#{rand(60..90)}0#{rand(1..9)}1#{rand(1..9)}200#{rand(1..9)}0#{rand(1..9)}#{rand(1..2)}#{rand(100...299)}"
    lecturer = Lecturer.create!(name: name, nik: nik)
    user = User.create!(email: email, password: 'password', password_confirmation: 'password', userable: lecturer)

    lecturer
  end

  def self.create_student(name, entry_year, status, department, supervisor_lecturer)
    university_domain = "uinjkt.ac.id"
    email = name.gsub(/[^0-9a-z ]/i, '').downcase().split(" ").join(".") + "@mhs.#{university_domain}"
    nim = "11#{entry_year % 2000}0910000#{rand(100..999)}"
    student = Student.create!(name: name, nim: nim, entry_year: entry_year, status: status, department: department, supervisor_lecturer: supervisor_lecturer)
    user = User.create!(email: email, password: 'password', password_confirmation: 'password', userable: student)

    student
  end
  
  def self.get_master_course_per_semester(department)
    master_course_per_semester = []
    (1..20).each { master_course_per_semester.push([]) }
    CSV.read("db/course_fixture.csv", headers: true).each do |r|
        semester = r["semester"].to_i
        c = Course.create!(name: r["name"], department: department, kind: r["kind"], credit: r["credit"])
        master_course_per_semester[semester].append(c)
    end

    master_course_per_semester
  end

  def self.fill_semester(students, semester, start_year, department, lecturers)
    current_year = start_year + (semester / 2)
    current_semester = semester % 2
    if current_semester == 0
      current_semester = 2
    end
    ApplicationConfig.find_by_key("year").update_attribute("value", current_year)
    ApplicationConfig.find_by_key("semester").update_attribute("value", current_semester)
    CourseYear.create(year: current_year, semester: current_semester)

    master_course_per_semester = Factory.get_master_course_per_semester(department)

    cpcs = []
    course_semesters = master_course_per_semester[semester].map do |course|
        CourseSemester.create!(year: current_year, semester: semester, course: course, lecturer: lecturers.sample())
    end
    students.each do |student|
        course_plan = CoursePlan.create!(year: current_year, semester: semester, student: student, is_approved: false)
        cpcs = course_semesters.map do |course_semester|
            CoursePlanCourseSemester.create!(course_plan: course_plan, course_semester: course_semester)
        end
        CoursePlanService.new(course_plan).submit
    end
    cpcs.each do |cpcs|
        crs = CourseResultScore.find_by_course_plan_course_semester_id(cpcs.id)
        crs.score = rand(3..4)
        crs.save
    end
  end
end