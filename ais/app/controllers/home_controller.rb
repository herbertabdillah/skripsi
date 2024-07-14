class HomeController < ApplicationController
  def index
    @users = User.all.limit(20)
  end
end
