class HomeController < ApplicationController
  def index
    redirect_to new_attendance_path
  end
end
