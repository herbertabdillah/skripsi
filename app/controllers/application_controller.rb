class ApplicationController < ActionController::Base
    before_action :set_paper_trail_whodunnit
    include Pundit::Authorization
end
