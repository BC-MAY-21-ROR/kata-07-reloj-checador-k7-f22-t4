module AttendancesHelper
  def check_complete?
    last_check = @employee.attendances.last
    !last_check.check_out? if last_check
  end
end
