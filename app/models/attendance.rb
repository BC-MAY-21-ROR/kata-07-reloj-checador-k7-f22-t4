# frozen_string_literal: true

# class for attendance model
class Attendance < ApplicationRecord
  belongs_to :employee

  scope :last_attendance, -> { where(check_in: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }

  def self.attendance_by_day(day, employee_id)
    attendances = Attendance.all
    range = day.beginning_of_day..day.end_of_day
    return attendances.where(check_in: range, employee_id: employee_id) if employee_id != ''

    attendances.where(check_in: range)
  end

  def self.average_check_time_by_month(date, check)
    attendances = month_attendances(date)
    return attendances unless attendances.length.positive?

    check_list = attendances.map { |attendance| check == true ? attendance.check_in : attendance.check_out }
    check_list.reject!(&:nil?)
    Time.at(average(check_list)).strftime('%k:%M')
  end

  def self.absence_list(date, employee_id)
    absences = []
    if employee_id != ''
      absences << { absence: absence(date, employee_id), id: employee_id, name: Employee.find_by(id: employee_id).name }
    else
      Employee.all.each do |employee|
        absences << { absence: absence(date, employee.id), id: employee.id, name: employee.name }
      end
    end
    absences
  end

  def self.range(date)
    date...(date + 1.months)
  end

  def self.average(attendances_list)
    check_in_average = 0
    return check_in_average unless attendances_list.length.positive?

    attendances_list.each { |date| (check_in_average += date.to_i) if date }
    check_in_average /= attendances_list.size
  end

  def self.month_attendances(date)
    Attendance.all.where(check_in: range(date))
  end

  def self.absence(date, employee_id)
    efective_day(date) - Employee.find_by(id: employee_id).attendances.where(check_in: range(date)).length
  end

  def self.efective_day(date)
    efective_day = range(date).reject do |day|
      week_day = day.wday
      week_day == 6 || week_day.zero?
    end
    date.month == Date.today.month ? (efective_day.length - (Date.today.end_of_month - Date.today).to_i) : efective_day.size
  end
end
