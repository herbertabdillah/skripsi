module FabricSync
  class Sync
    def initialize
      @adapter = FabricSync::Adapter.new
    end

    def master_data(start_date: nil, ids: nil)
      sync(Faculty, start_date: start_date, ids: ids) { |faculty| @adapter.insert_faculty(faculty) }
      sync(Department, start_date: start_date, ids: ids) { |department| @adapter.insert_department(department) }
      sync(Course, start_date: start_date, ids: ids) { |course| @adapter.insert_course(course) }
    end

    def user(start_date: nil, ids: nil)
      sync(Lecturer, start_date: start_date, ids: ids) { |lecturer| @adapter.insert_lecturer(lecturer) }
      sync(Student, start_date: start_date, ids: ids) { |student| @adapter.insert_student(student) }
    end

    # # Administration
    # start_year(year, semester)
    # end_year(year, semester)
    # insert_course_semester(course_semester)

    def administration(start_date: nil, ids: nil)
      sync(CourseSemester, start_date: start_date, ids: ids) { |course_semester| @adapter.insert_course_semester(course_semester) }
    end

    def course(start_date: nil, ids: nil)
      sync(CoursePlan, start_date: start_date, ids: ids) { |course_plan| @adapter.insert_course_plan(course_plan) }
      sync(CourseResultScore, start_date: start_date, ids: ids) { |course_result_score| @adapter.update_course_result(course_result_score) }
    end

    def graduation(start_date: nil, ids: nil)
      sync(Graduate, start_date: start_date, ids: ids) { |graduate| @adapter.graduate(graduate.student_id) }
    end

    # # Graduation
    # graduate(id)
    private

    def sync(clazz, start_date: nil, ids: nil, &block)
      data = nil

      if start_date
        data = clazz.where('created_at > ?', start_date)
      elsif ids
        data = clazz.where(id: ids)
      else
        raise  
      end

      data.each do |obj|
        block.call obj
        BlockchainSync.create status: "success", syncable: obj
      rescue StandardError => e
        BlockchainSync.create status: "error", syncable: obj, description: e.message
      end
    end
  end
end