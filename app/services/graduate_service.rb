class GraduateService
  def initialize(student)
    @student = student
    @transcript_service = TranscriptService.new(@student)
  end

  def graduate
    raise StandardError, 'Havent done all course' unless @transcript_service.have_done_all_course?

    score = @transcript_service.cumulative_score

    graduate = Graduate.new(student: @student, score: score, year: 2023)
    graduate.save

    @student.status = :graduated
    @student.save
  end
end