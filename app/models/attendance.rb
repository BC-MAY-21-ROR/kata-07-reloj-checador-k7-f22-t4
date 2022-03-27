class Attendance < ApplicationRecord
  belongs_to :employee

  def self.attendance_by_day(day)
    Attendance.all.where(check_in: day.beginning_of_day..day.end_of_day)
  end

  def self.average_check_out_time_by_month(date)
    attendances = month_attendances(date)
    check_in = attendances.map { |attendance| attendance.check_in }
    average(check_in)
  end

  def self.average_check_in_time_by_month(date)
    attendances = month_attendances(date)
    check_out = attendances.map { |attendance| attendance.check_out }
    average(check_out)
  end

  def self.absence_list(date)
    absences = Array.new()
    Employee.all.each { |employee| absences << { absence: absence_by_month(date, employee.id), id: employee.id, name: employee.name } }
    return absences
  end

  private

  def self.range(date)
    beginning_of_month(date)...beginning_of_month(date) + 1.months
  end
  
  def self.beginning_of_month(date)
    Date.parse(date.strftime("%B"))
  end

  def self.average(attendances_list)
    check_in_average = 0
    attendances_list.each { |date| check_in_average += date.hour }
    check_in_average /= attendances_list.length
  end

  def self.month_attendances(date)
    Attendance.all.where(check_in: range(date))
  end

  def self.absence_by_month(date, employee_id)
    employee = Employee.find_by(id: employee_id)
    attendances = employee.attendances.where(check_in: range(date))
    efective_day_of_month(date).length - attendances.length 
  end

  def self.efective_day_of_month(date)
    (range(date)).reject { |day| day.wday == 6 || day.wday.zero? }
  end
end
