require "contract"
module FabricSync
  class SyncGrade
    def initialize
      @contract = FabricConnection::Contract.get_contract 'contract'
    end

    def add_grade(student_id, graduated)
      @contract.submit_transaction 'PerkuliahanContract:addGrade', [student_id.to_s, graduated.to_s]
    end

    def get_grade(student_id)
      res = @contract.evaluate_transaction('PerkuliahanContract:getGrade', ["grade.#{student_id.to_s}"])

      deserialize res
    end
    
    private

    def deserialize(grade_string)
      h = JSON.parse grade_string
      g = Grade.new
      g.student_id = h['studentId']
      g.graduated = h['graduated']

      g
    end
  end
end