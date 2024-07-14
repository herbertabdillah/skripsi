ActiveAdmin.register Student, as: 'Transcript' do
  menu parent: 'Academic'#, if: proc{ current_user.student? }

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :course_plan_id, :score
  #
  # or
  #
  # permit_params do
  #   permitted = [:course_plan_id, :score]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    column :id
    # column(:student) { |c| c.course_plan.student }
    column :name
    actions
    # column :updated_at
    # link_to 'view', action: :show
  end

  show do |course_result|
    attributes_table do
      transcript_result = TranscriptService.new(resource)
      row(:score) { transcript_result.cumulative_score.round(2) }
      row(:total_credit) { transcript_result.total_credit }
      # row(:semester) { |c| c.course_plan.semester }
      # row(:year) { |c| c.course_plan.year }
    end

    cr = CourseResult.includes(:course_plan).all.where(course_plan: {student: resource}).order(:id)
    # if current_user.lecturer?
    #   cr = cr.includes(:course_plan).where(course_plan: {students: resource})
    # elsif current_user.student? 
    #   cr = cr.includes(:course_plan).where(course_plan: {student: resource})
    # end

    cr.each do |c|
      panel 'Course Taken' do
        counter = 0
        attributes_table do
          transcript_result = c.get_transcript
          row(:score) { transcript_result[:score].round(2) }
          row(:total_credit) { transcript_result[:total_credit] }
          row(:semester) { |student| student.relative_semester(c.course_plan.year, c.course_plan.semester) }
          row(:year) { c.course_plan.year }
        end

        table_for c.course_result_scores do
          column(:no) { counter += 1 }
          column(:name) { |crs| crs.course_semester.course.name }
          column(:lecturer) { |crs| crs.course_semester.lecturer.name }
          column(:credit) { |crs| crs.course_semester.course.credit }
          column(:score)

        end
      end
    end
  end 

  controller do
    def scoped_collection
      if current_user.is_admin?
        super
      elsif current_user.lecturer?
        super.where(supervisor_lecturer: current_user.userable)
      elsif current_user.student? 
        super.where(id: current_user.userable.id)
      else
        super
      end
    end
  end
end
