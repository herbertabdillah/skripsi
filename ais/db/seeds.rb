require "factory"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ActiveRecord::Base.transaction do
    Rails.logger.info("start")
    start_year = 2017
    current_year = start_year
    current_semester = 1
    university_domain = "uinjkt.ac.id"

    ApplicationConfig.create(key: "year", value: current_year)
    ApplicationConfig.create(key: "semester", value: current_semester)

    Factory.create_admin

    faculty = Faculty.create!(name: "Sains dan Teknologi")
    department = Department.create!(name: "Teknik Informatika", faculty: faculty)
    # master_course_per_semester = []
    # (1..20).each { master_course_per_semester.push([]) }

    # master_course_per_semester = Factory.get_master_course_per_semester


    lecturers = (1..1).map do
        # Factory.create_lecturer(Faker::Name.name)
        Factory.create_lecturer("lecturer a")
    end
    # students = (1..3).map do |i|
    #     # lecturer_idx = lecturers.length % i
    #     # Factory.create_student(Faker::Name.name, 2017, "active", department, lecturers[lecturer_idx])
    #     Factory.create_student(Faker::Name.name, 2017, "active", department, lecturers.sample)
    # end

    students = [
        Factory.create_student("student a", 2017, "active", department, lecturers.sample),
        Factory.create_student("student b", 2017, "active", department, lecturers.sample),
        Factory.create_student(Faker::Name.name, 2017, "active", department, lecturers.sample),
    ]

    Rails.logger.info("master done")

    (1..1).each do |semester|
        Factory.fill_semester(students, semester, start_year, department, lecturers)
        # current_year = start_year + (semester / 2)
        # ApplicationConfig.find_by_key("year").update_attribute("value", current_year)
        # ApplicationConfig.find_by_key("semester").update_attribute("value", current_semester)

        # cpcs = []
        # course_semesters = master_course_per_semester[semester].map do |course|
        #     CourseSemester.create!(year: current_year, semester: semester, course: course, lecturer: lecturers.sample())
        # end
        # students.each do |student|
        #     course_plan = CoursePlan.create!(year: current_year, semester: semester, student: student, is_approved: false)
        #     cpcs = course_semesters.map do |course_semester|
        #         CoursePlanCourseSemester.create!(course_plan: course_plan, course_semester: course_semester)
        #     end
        #     CoursePlanService.new(course_plan).submit
        # end
        # cpcs.each do |cpcs|
        #     crs = CourseResultScore.find_by_course_plan_course_semester_id(cpcs.id)
        #     crs.score = rand(3..4)
        #     crs.save
        # end
    end
end