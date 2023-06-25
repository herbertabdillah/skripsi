module FabricSync
  class Adapter
    def initialize
      @contract = FabricSync::Contract.new
    end

    def sync(start_date)
      Faculty.where('created_at > ?', start_date).each do |faculty|
        add_faculty(faculty.id, faculty.name)
      end
    end

    # MasterData

    def insert_faculty(faculty)
      @contract.insert_faculty(faculty.id, faculty.name)
    end

    def get_faculty(id)
      @contract.get_faculty(id)
    end
    
    def insert_department(department)
      @contract.insert_department(department.id, department.name, department.faculty_id)
    end

    def get_department(id)
      @contract.get_department(id)
    end

    def insert_course(course)
      @contract.insert_course(course.id, course.department_id, course.name, course.credit, course.kind)
    end

    def get_course(id)
      @contract.get_course(id)
    end   

    # User

    def insert_lecturer(lecturer)
      @contract.insert_lecturer(lecturer.id, lecturer.name, lecturer.nik)
    end

    def get_lecturer(id)
      @contract.get_lecturer(id)
    end

    def insert_student(student)
      @contract.insert_student(student.id, student.name, student.nim, student.department_id, student.entry_year,
                              student.status, student.supervisor_lecturer_id)
    end

    def get_student(id)
      @contract.get_student(id)
    end   

    # Administration

    def start_year(year, semester)
      @contract.start_year(year, semester)
    end

    def end_year(year, semester)
      @contract.end_year(year, semester)
    end

    def get_course_year(year, semester)
      @contract.get_course_year(year, semester)
    end   

    def insert_course_semester(course_semester)
      @contract.insert_course_semester(course_semester.id, course_semester.year, semester(course_semester.semester), course_semester.course_id,
                                      course_semester.lecturer_id)
    end

    def get_course_semester(id)
      @contract.get_course_semester(id)
    end   

    # Course
    def insert_course_plan(course_plan)
      status = "approved"
      course_semester_ids = course_plan.course_plan_course_semesters.map { |cpcs| cpcs.course_semester_id.to_s }
      @contract.insert_course_plan(course_plan.id, course_plan.year, semester(course_plan.semester), course_plan.student_id, status, course_semester_ids)
    end

    def get_course_plan(id)
      @contract.get_course_plan(id)
    end   

    def update_course_result(course_result_score)
      course_semester_id = course_result_score.course_semester.id
      @contract.update_course_result(course_semester_id, course_result_score.course_plan_id, course_result_score.score)
    end

    def get_course_result(id)
      @contract.get_course_result(id)
    end   

    # Graduation

    def graduate(id)
      @contract.graduate(id)
    end

    def get_transcript(id)
      @contract.get_transcript(id)
    end   

    private

    def semester(number)
      if number == 1
        return 'odd'
      else
        return 'even'
      end
    end
  end
end