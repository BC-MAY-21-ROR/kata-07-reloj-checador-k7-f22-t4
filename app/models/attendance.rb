class Attendance < ApplicationRecord
  belongs_to :employee

  def self.attendance_by_day(day)
    Attendance.all.where(check_in: Date.parse(day).beginning_of_day..Date.parse(day).end_of_day)
  end

  def self.average_check_in_time_by_month(date)
    attendances = month_attendances(date)
    if attendances.length > 0
      check_in = attendances.map { |attendance| attendance.check_in }
      Time.at(average(check_in)).strftime("%k:%M")
    end 
  end

  def self.average_check_out_time_by_month(date)
    attendances = month_attendances(date)
    if attendances.length > 0
      check_out = attendances.map { |attendance| attendance.check_out }
      Time.at(average(check_out)).strftime("%k:%M")
    end
  end

  def self.absence_list(date)
    absences = Array.new()
    Employee.all.each { |employee| absences << { absence: absence_by_month(date, employee.id), id: employee.id, name: employee.name } }
    return absences
  end

  private

  def self.range(date)
    Date.parse(date)...(Date.parse(date) + 1.months)
  end

  def self.parse_date(date)
    Date.parse(date)
  end

  def self.average(attendances_list)
    check_in_average = 0
    if attendances_list.length > 0
      attendances_list.each { |date| check_in_average += (date.to_time).to_i }
      check_in_average /= attendances_list.length
    end
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
