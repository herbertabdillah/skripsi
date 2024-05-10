class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :set_paper_trail_whodunnit
    include Pundit::Authorization
end
