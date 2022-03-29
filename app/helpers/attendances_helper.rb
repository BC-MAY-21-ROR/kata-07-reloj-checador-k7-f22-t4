module AttendancesHelper
  def check_today?
    @attendance.check_out if @attendance
  end

  def reports_params(params)
    if params.key?(:day)
      (params[:day] = Date.parse(params[:day])) if params[:day] != ''
      return params
    end
    reports_values = { day: DateTime.now, employee_id: '' }
  end

  def get_average(average, flag)
    Attendance.average_check_time_by_month(@avg_month, flag)
  end
end
