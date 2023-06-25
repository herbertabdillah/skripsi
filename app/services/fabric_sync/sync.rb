module FabricSync
  class Sync
    def initialize
      @adapter = FabricSync::Adapter.new
    end

    # All, for cron job

    def run(start_date:)
      group_master_data start_date: start_date
      group_user start_date: start_date
      group_administration start_date: start_date
      group_course start_date: start_date
      group_graduation start_date: start_date
    end

    # Manual - group

    def group_master_data(start_date: nil)
      faculty start_date: start_date
      department start_date: start_date
      course start_date: start_date
    end

    def group_user(start_date: nil)
      lecturer start_date: start_date
      student start_date: start_date
    end

    def group_administration(start_date: nil)
      course_semester start_date: start_date
    end

    def group_course(start_date: nil)
      course_plan start_date: start_date
      course_result_score start_date: start_date
    end

    def group_graduation(start_date: nil)
      graduate start_date: start_date
    end

    def start_end_year(year, semester)
      @adapter.start_year(year, semester)
      @adapter.end_year(year, semester)
    end

    def start_year(year, semester)
      @adapter.start_year(year, semester)
      @adapter.end_year(year, semester)
    end

    # Manual - each

    # master_data

    def faculty(start_date: nil, ids: nil)
      sync(Faculty, start_date: start_date, ids: ids) { |faculty| @adapter.insert_faculty(faculty) }
    end

    def department(start_date: nil, ids: nil)
      sync(Department, start_date: start_date, ids: ids) { |department| @adapter.insert_department(department) }
    end

    def course(start_date: nil, ids: nil)
      sync(Course, start_date: start_date, ids: ids) { |course| @adapter.insert_course(course) }
    end

    # user

    def lecturer(start_date: nil, ids: nil)
      sync(Lecturer, start_date: start_date, ids: ids) { |lecturer| @adapter.insert_lecturer(lecturer) }
    end

    def student(start_date: nil, ids: nil)
      sync(Student, start_date: start_date, ids: ids) { |student| @adapter.insert_student(student) }
    end

    # administration

    def course_semester(start_date: nil, ids: nil)
      sync(CourseSemester, start_date: start_date, ids: ids) { |course_semester| @adapter.insert_course_semester(course_semester) }
    end

    # course

    def course_plan(start_date: nil, ids: nil)
      sync(CoursePlan, start_date: start_date, ids: ids) { |course_plan| @adapter.insert_course_plan(course_plan) }
    end

    def course_result_score(start_date: nil, ids: nil)
      sync(CourseResultScore, start_date: start_date, ids: ids, filter: 'updated_at') { |course_result_score| @adapter.update_course_result(course_result_score) }
    end

    # graduation

    def graduate(start_date: nil, ids: nil)
      sync(Graduate, start_date: start_date, ids: ids) { |graduate| @adapter.graduate(graduate.student_id) }
    end

    private

    def sync(clazz, start_date: nil, ids: nil, filter: 'created_at', &block)
      data = nil

      if start_date
        data = clazz.where("#{filter} > ?", start_date)
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