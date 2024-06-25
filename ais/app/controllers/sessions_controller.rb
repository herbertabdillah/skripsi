class SessionsController < Devise::SessionsController
  def new
    if params['email'].present?
      User.find_by_email(params['email'])
    end

    super
  end
end