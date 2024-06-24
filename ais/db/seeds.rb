# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def create_lecturer(name)
    university_domain = "uinjkt.ac.id"
    email = name.gsub(/[^0-9a-z ]/i, '').downcase().split(" ").join(".") + "@#{university_domain}"
    nik = "19#{rand(60..90)}0#{rand(1..9)}1#{rand(1..9)}200#{rand(1..9)}0#{rand(1..9)}#{rand(1..2)}#{rand(100...299)}"
    lecturer = Lecturer.create!(name: name, nik: nik)
    user = User.create!(email: email, password: 'password', password_confirmation: 'password', userable: lecturer)

    return lecturer
end

def create_student(name, entry_year, status, department, supervisor_lecturer)
    university_domain = "uinjkt.ac.id"
    email = name.gsub(/[^0-9a-z ]/i, '').downcase().split(" ").join(".") + "@mhs.#{university_domain}"
    nim = "11#{entry_year % 2000}0910000#{rand(100..999)}"
    student = Student.create!(name: name, nim: nim, entry_year: entry_year, status: status, department: department, supervisor_lecturer: supervisor_lecturer)
    user = User.create!(email: email, password: 'password', password_confirmation: 'password', userable: student)

    student
end

ActiveRecord::Base.transaction do
    Rails.logger.info("start")
    start_year = 2017
    current_year = start_year
    current_semester = 1
    university_domain = "uinjkt.ac.id"

    ApplicationConfig.create(key: "year", value: current_year)
    ApplicationConfig.create(key: "semester", value: current_semester)

    lecturer_admin = Lecturer.create!(name: "admin", nik: "0")
    User.create!(email: "admin@#{university_domain}", password: 'password', password_confirmation: 'password', userable: lecturer_admin)

    faculty = Faculty.create!(name: "Sains dan Teknologi")
    department = Department.create!(name: "Teknik Informatika", faculty: faculty)
    master_course_per_semester = []
    (1..20).each { master_course_per_semester.push([]) }

    CSV.read("db/course_fixture.csv", headers: true).each do |r|
        semester = r["semester"].to_i
        c = Course.create!(name: r["name"], department: department, kind: r["kind"], credit: r["credit"])
        master_course_per_semester[semester].append(c)
    end

    lecturers = (1..3).map do
        create_lecturer(Faker::Name.name)
    end
    students = (1..20).map do |i|
        # lecturer_idx = lecturers.length % i
        # create_student(Faker::Name.name, 2017, "active", department, lecturers[lecturer_idx])
        create_student(Faker::Name.name, 2017, "active", department, lecturers.sample)
    end

    Rails.logger.info("master done")

    (1..7).each do |semester|
        current_year = start_year + (semester / 2)
        ApplicationConfig.find_by_key("year").update_attribute("value", current_year)
        ApplicationConfig.find_by_key("semester").update_attribute("value", current_semester)

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