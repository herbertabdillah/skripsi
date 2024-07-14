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
    student = Student.create!(id: nim, name: name, nim: nim, entry_year: entry_year, status: status, department: department, supervisor_lecturer: supervisor_lecturer)
    user = User.create!(email: email, password: 'password', password_confirmation: 'password', userable: student)

    student
  end
    
  def self.insert_master_course_per_semester(department)
    master_course_per_semester = []
    (1..20).each { master_course_per_semester.push([]) }
    CSV.read("db/course_fixture.csv", headers: true).each do |r|
        semester = r["semester"].to_i
        c = Course.create!(name: r["name"], department: department, kind: r["kind"], credit: r["credit"])
        master_course_per_semester[semester].append(c)
    end

    master_course_per_semester
  end

  def self.get_master_course_per_semester(department)
    master_course_per_semester = []
    (1..20).each { master_course_per_semester.push([]) }
    CSV.read("db/course_fixture.csv", headers: true).each do |r|
        semester = r["semester"].to_i
        c = Course.where(name: r["name"], department: department, kind: r["kind"], credit: r["credit"]).first
        master_course_per_semester[semester].append(c)
    end

    master_course_per_semester
  end

  # Factory.fill_semester(Student.all, 2, 2017, Department.first, Lecturer.all)
  def self.fill_semester(students, semester, start_year, department, lecturers)
    current_year = start_year + (semester / 2)
    current_semester = semester % 2
    if current_semester == 0
      current_semester = 2
    end
    CourseYear.create_from_semester_int(year: current_year, semester: current_semester)

    master_course_per_semester = Factory.get_master_course_per_semester(department)

    # cpcs = []
    if master_course_per_semester[semester].empty?
      return
    end

    course_semesters = master_course_per_semester[semester].map do |course|
        CourseSemester.create!(year: current_year, semester: current_semester, course: course, lecturer: lecturers.sample())
    end
    students.each do |student|
        course_plan = CoursePlan.create!(year: current_year, semester: current_semester, student: student, is_approved: false)
        cpcs = course_semesters.map do |course_semester|
            CoursePlanCourseSemester.create!(course_plan: course_plan, course_semester: course_semester)
        end
        CoursePlanService.new(course_plan).submit
    end
    students.each do |student|
      course_plan = CoursePlan.where(year: current_year, semester: current_semester, student: student)
      cpcs = CoursePlanCourseSemester.where(course_plan: course_plan)
      cpcs.each do |cpcs|
        crs = CourseResultScore.find_by_course_plan_course_semester_id(cpcs.id)
        crs.score = rand(3..4)
        crs.save
      end
    end
  end

  # Factory.fill_semester_plan(Student.all, 2, 2017, Department.first, Lecturer.all)
  def self.fill_semester_plan(students, semester, start_year, department, lecturers)
    current_year = start_year + (semester / 2)
    current_semester = semester % 2
    if current_semester == 0
      current_semester = 2
    end
    CourseYear.create_from_semester_int(year: current_year, semester: current_semester)

    master_course_per_semester = Factory.get_master_course_per_semester(department)

    # cpcs = []
    course_semesters = master_course_per_semester[semester].map do |course|
        CourseSemester.create!(year: current_year, semester: current_semester, course: course, lecturer: lecturers.sample())
    end
    students.each do |student|
        course_plan = CoursePlan.create!(year: current_year, semester: current_semester, student: student, is_approved: false)
        cpcs = course_semesters.map do |course_semester|
            CoursePlanCourseSemester.create!(course_plan: course_plan, course_semester: course_semester)
        end
        # CoursePlanService.new(course_plan).submit
    end
  end

  def self.fill_semester_and_sync(semester, start)
    student = Student.all
    if semester > 4
      student = Student.where.not(name: "mahasiswa abadi").all
    end
    if semester == 8
      student = Student.where.not(name: "mahasiswa abadi").each do |s|
        graduate_service = GraduateService.new(s)
        graduate_service.graduate
      end
    end
    Factory.fill_semester(Student.all, semester, start, Department.first, Lecturer.all)
    BlockchainSyncBatch.create(description: "#{CourseYear.active.year} #{CourseYear.active.semester}")
  end

  def self.fill_semester_and_sync_until(start_semester, until_semester)
    (start_semester..until_semester).each do |semester|
      Factory.fill_semester_and_sync(semester, 2017)
      ready_to_go = false
      while (!ready_to_go)
        bsb = BlockchainSyncBatch.last
        sleep(5)
        Rails.logger.info("#{bsb.description} #{bsb.status}")
        if bsb.success?
          ready_to_go = true
        end
      end
    end
  end
end