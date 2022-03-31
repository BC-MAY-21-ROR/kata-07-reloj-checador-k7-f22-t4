module AttendancesHelper
  def check_today?
    @attendance.check_out if @attendance
  end

  def reports_params(params)
    if params.key?(:day)
      (params[:day] = Date.parse(params[:day])) if params[:day] != ''
      return params
    end
    employee = params.key?(:employee_id) ? params[:employee_id] : ''
    reports_values = { day: DateTime.now, employee_id: employee }
  end

  def get_average(average, flag)
    Attendance.average_check_time_by_month(@avg_month, flag)
  end
end
