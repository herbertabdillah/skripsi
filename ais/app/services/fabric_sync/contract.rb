require "contract"
module FabricSync
  class Contract
    def initialize
      @contract = FabricConnection::Contract.get_contract 'contract'
    end

    # MasterData

    def insert_faculty(id, name)
      submit 'MasterData:insertFaculty', [id.to_s, name]
    end

    def get_faculty(id)
      res = @contract.evaluate_transaction('MasterData:getFaculty', [id.to_s])

      JSON.parse(res)
    end
    
    def insert_department(id, name, faculty_id)
      submit 'MasterData:insertDepartment', [id.to_s, name, faculty_id.to_s]
    end

    def get_department(id)
      res = @contract.evaluate_transaction('MasterData:getDepartment', [id.to_s])

      JSON.parse(res)
    end

    def insert_course(id, department_id, name, credit, kind)
      submit 'MasterData:insertCourse', [id.to_s, department_id.to_s, name, credit.to_s, kind]
    end

    def get_course(id)
      res = @contract.evaluate_transaction('MasterData:getCourse', [id.to_s])

      JSON.parse(res)
    end   

    # User

    def insert_lecturer(id, name, nik)
      submit 'User:insertLecturer', [id.to_s, name, nik]
    end

    def get_lecturer(id)
      res = @contract.evaluate_transaction('User:getLecturer', [id.to_s])

      JSON.parse(res)
    end

    def insert_student(id, name, nim, department_id, entry_year, status, supervisor_lecturer_id)
      submit 'User:insertStudent', [id.to_s, name, nim, department_id.to_s, entry_year.to_s, status, supervisor_lecturer_id.to_s]
    end

    def get_student(id)
      res = @contract.evaluate_transaction('User:getStudent', [id.to_s])

      JSON.parse(res)
    end   

    # Administration

    def start_year(year, semester)
      submit 'Administration:startYear', [year.to_s, semester]
    end

    def end_year(year, semester)
      submit 'Administration:endYear', [year.to_s, semester]
    end

    def get_course_year(year, semester)
      res = @contract.evaluate_transaction('Administration:getCourseYear', [year.to_s, semester])

      JSON.parse(res)
    end   

    def insert_course_semester(id, year, semester, course_id, lecturer_id)
      submit 'Administration:insertCourseSemester', [id.to_s, year.to_s, semester, course_id.to_s, lecturer_id.to_s]
    end

    def get_course_semester(id)
      res = @contract.evaluate_transaction('Administration:getCourseSemester', [id.to_s])

      JSON.parse(res)
    end   

    # Course
    def insert_course_plan(id, year, semester, student_id, status, course_semester_ids)
      submit 'Course:insertCoursePlan', [id.to_s, year.to_s, semester, student_id.to_s, status, course_semester_ids.to_s]
    end

    def get_course_plan(id)
      res = @contract.evaluate_transaction('Course:getCoursePlan', [id.to_s])

      JSON.parse(res)
    end   

    def update_course_result(course_semester_id, course_result_id, score)
      submit 'Course:updateCourseResult', [course_semester_id.to_s, course_result_id.to_s, score.to_s]
    end

    def get_course_result(id)
      res = @contract.evaluate_transaction('Course:getCourseResult', [id.to_s])

      JSON.parse(res)
    end   

    # Graduation

    def graduate(id)
      submit 'Graduation:graduate', [id.to_s]
    end

    def get_transcript(id)
      res = @contract.evaluate_transaction('Graduation:getTranscript', [id.to_s])

      JSON.parse(res)
    end   

    private

    def submit(contract_name, param)

      submit_error = nil
      evaluate_error = nil

      proposal = @contract.new_proposal(contract_name, arguments: param)
      tx_id = proposal.transaction_id

      res = {
        contract_name: contract_name,
        param: param,
        success: true,
        error: nil,
        transaction_id: tx_id,
        result: nil,
      }

      begin
        # @contract.submit_transaction contract_name, param
        # contract_submit_with_tx_id(contract_name, param)
        res[:result] = submit_proposal(proposal)
      rescue StandardError => e
        submit_error = e
      end

      return res unless submit_error

      begin
        @contract.evaluate_transaction contract_name, param
      rescue StandardError => e
        evaluate_error = e
      end

      if evaluate_error
        # raise StandardError, evaluate_error.to_rpc_status.message
        res[:success] = false
        res[:error] = evaluate_error.to_rpc_status.message
      else
        # raise submit_error
        res[:success] = false
        res[:error] = submit_error
      end

      return res
    end

    def submit_proposal(proposal)
      endorsed_proposal = proposal.endorse
      submitted_transaction = endorsed_proposal.submit

      return submitted_transaction.result

      # {
      #   success: true,
      #   error: nil,
      #   transaction_id: proposal.transaction_id,
      #   result: submitted_transaction.result
      # }
    end

    def deserialize(raw)
      h = JSON.parse raw
      resource = Faculty.new
      resource.name = h['name']
      resource.id = h['id']

      resource
    end
  end
end