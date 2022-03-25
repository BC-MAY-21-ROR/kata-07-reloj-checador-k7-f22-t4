class Attendance < ApplicationRecord
  belongs_to :employee

  def attendance_by_day(day)
    Attendance.all.where(check_in: Date.parse(day).beginning_of_day..Date.parse(day).end_of_day)
  end
end
