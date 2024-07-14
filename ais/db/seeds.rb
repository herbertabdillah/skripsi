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

    Factory.create_admin

    faculty = Faculty.create!(name: "Sains dan Teknologi")
    department = Department.create!(name: "Teknik Informatika", faculty: faculty)

    lecturers = (1..1).map do
        Factory.create_lecturer("lecturer a")
    end
    students = [
        Factory.create_student("student a", 2017, "active", department, lecturers.sample),
        Factory.create_student("student b", 2017, "active", department, lecturers.sample),
        Factory.create_student(Faker::Name.name, 2017, "active", department, lecturers.sample),
    ]

    Rails.logger.info("master done")
    Factory.insert_master_course_per_semester(department)

    # (1..1).each do |semester|
    #     Factory.fill_semester(students, semester, start_year, department, lecturers)
    # end
end