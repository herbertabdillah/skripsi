ActiveAdmin.register Attendance do
  belongs_to :student

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :week_number, :attended, :student_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:week_number, :attended, :student_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  controller do
    def create
      s = FabricSync::SyncAttendance.new
      a = params[:attendance]
      attended = a[:attended] == "1" ? true : false
      s.add_attendance(a[:student_id], attended, a[:week_number])
      super
    end
  end
  
end
