require "contract"
module FabricSync
  class SyncAttendance
    def initialize
      @contract = FabricConnection::Contract.get_contract 'contract'
    end

    def add_attendance(student_id, attended, week_number)
      @contract.submit_transaction 'PerkuliahanContract:addAttendance', [student_id.to_s, attended.to_s, week_number.to_s]
    end

    def get_attendance(student_id, week_number)
      res =  @contract.evaluate_transaction('PerkuliahanContract:getAttendance', ["attendance.#{student_id.to_s}.#{week_number.to_s}"])

      deserialize res
    end

    private

    def deserialize(attendance_string)
      h = JSON.parse attendance_string
      a = Attendance.new
      a.student_id = h['studentId']
      a.attended = h['attended']
      a.week_number = h['weekNumber']

      a
    end
  end
end