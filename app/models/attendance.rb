class Attendance < ApplicationRecord
  belongs_to :employee

  def attendance_by_day(day)
    Attendance.all.where(check_in: Date.parse(day).beginning_of_day..Date.parse(day).end_of_day)
  end

  def average_check_out_time_by_month(month)
    attendances = month_attendances(month)
    check_in = attendances.map { |attendance| attendance.check_in }
    average(check_in)
  end

  def average_check_in_time_by_month(month)
    attendances = month_attendances(month)
    check_out = attendances.map { |attendance| attendance.check_out }
    average(check_out)
  end

  def month_attendances
    Attendance.all.where(check_in: Date.parse(month)..Date.parse(month) + 1.months)
  end

  def average(attendances_list)
    check_in_average = 0
    attendances_list.each { |date| check_in_average += date.hour }
    check_in_average /= attendances_list.length
  end

  def absence_by_month(month, employee_id)
    employee = Employee.find_by(id: employee_id)
    attendances = employee.attendances.where(check_in: Date.parse(month)..Date.parse(month) + 1.months)
    attendances.legth - efective_day_of_month(month).length
  end

  def efective_day_of_month(month)
    (Date.parse(month)...Date.parse(month) + 1.months).reject { |day| day.wday == 6 || day.wday.zero? }
  end
end
