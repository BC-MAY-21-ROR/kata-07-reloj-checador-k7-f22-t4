class Attendance < ApplicationRecord
  belongs_to :employee

  def self.attendance_by_day(day, employee_id)
    attd = Attendance.all.where(check_in: day.beginning_of_day..day.end_of_day)
    if employee_id && employee_id != "" && Employee.exists?(employee_id)
      attd = Attendance.all.where(check_in: day.beginning_of_day..day.end_of_day, employee_id: employee_id)
    end
    attd
  end

  def self.average_check_in_time_by_month(date)
    attendances = month_attendances(date)
    if attendances.length > 0
      check_in = attendances.map { |attendance| attendance.check_in }
      Time.at(average(check_in)).strftime('%k:%M')
    end 
  end

  def self.average_check_out_time_by_month(date)
    attendances = month_attendances(date)
    if attendances.length > 0
      check_out = attendances.map { |attendance| attendance.check_out }
      Time.at(average(check_out)).strftime('%k:%M')
    end
  end

  def self.absence_list(date, employee_id)
    absences = Array.new()
    if employee_id && employee_id != '' && Employee.exists?(employee_id)
      absences << { absence: absence_by_month(date, employee_id), id: employee_id, name: Employee.find_by(id: employee_id).name } 
    else
      Employee.all.each { |employee| absences << { absence: absence_by_month(date, employee.id), id: employee.id, name: employee.name } }
    end
    return absences
  end

  private

  def self.range(date)
    date...(date + 1.months)
  end

  def self.average(attendances_list)
    check_in_average = 0
    if attendances_list.length > 0
      attendances_list.each { |date| (check_in_average += (date.to_time).to_i) if date}
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
