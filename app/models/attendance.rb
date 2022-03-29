# frozen_string_literal: true

# class for attendance model
class Attendance < ApplicationRecord
  belongs_to :employee

  def self.attendance_by_day(day, employee_id)
    attendances = Attendance.all
    range = day.beginning_of_day..day.end_of_day
    att = attendances.where(check_in: range)
    if employee_id && employee_id != '' && Employee.exists?(employee_id)
      att = attendances.where(check_in: range, employee_id: employee_id)
    end
    att
  end

  def self.average_check_time_by_month(date, check)
    attendances = month_attendances(date)
    if attendances.length.positive?
      check_in = attendances.map { |attendance| check == true ? attendance.check_in : attendance.check_out }
      Time.at(average(check_in)).strftime('%k:%M')
    end
  end

  def self.absence_list(date, employee_id)
    absences = []
    if employee_id && employee_id != '' && Employee.exists?(employee_id)
      absences << { absence: absence_by_month(date, employee_id), id: employee_id,
                    name: Employee.find_by(id: employee_id).name }
    else
      Employee.all.each do |employee|
        absences << { absence: absence_by_month(date, employee.id), id: employee.id, name: employee.name }
      end
    end
    absences
  end

  def self.range(date)
    date...(date + 1.months)
  end

  def self.average(attendances_list)
    check_in_average = 0
    if attendances_list.length.positive?
      attendances_list.each { |date| (check_in_average += date.to_time.to_i) if date }
      check_in_average /= attendances_list.size
    end
  end

  def self.month_attendances(date)
    attendances = []
    Attendance.all.where(check_in: range(date))
  end

  def self.absence_by_month(date, employee_id)
    efective_day(date) - Employee.find_by(id: employee_id).attendances.where(check_in: range(date)).length
  end

  def self.efective_day(date)
    efective_day = range(date).reject do |day|
      week_day = day.wday
      week_day == 6 || week_day.zero?
    end
    efective_day.size
  end
end
