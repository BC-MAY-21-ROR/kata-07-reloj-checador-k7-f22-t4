class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[show edit update destroy]
  before_action :authenticate_admin!, except: %i[new create]

  # GET /attendances or /attendances.json
  def index
    values = (helpers.reports_params(params))
    @attendances = Attendance.attendance_by_day(values[:day], values[:employee_id])
    @absences = Attendance.absence_list(Date.parse("#{values[:absence_month]}-01"), values[:employee_id])
    @avg_month = Date.parse("#{values[:avg_month]}-01")
  end

  # GET /attendances/1 or /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  def edit
  end

  # POST /attendances or /attendances.json
  def create
    @employee = Employee.find_by(private_code: attendance_params[:employee_id])
    return redirect_to new_attendance_path, alert: "Employee doesn't exist" unless @employee
    
    @attendance = @employee.attendances.where(check_in: DateTime.now.beginning_of_day..DateTime.now.end_of_day).last
    if helpers.check_today?
      redirect_to new_attendance_path, alert: "You already have assistence today"
    else
      @attendance ? new_check_out : new_check_in
    end
  end

  # DELETE /attendances/1 or /attendances/1.json
  def destroy
    @attendance.destroy

    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def attendance_params
    params.require(:attendance).permit(:employee_id)
  end

  def new_check_in
    new_atte = { check_in: DateTime.now, employee_id: @employee.id }
    @attendance = Attendance.new(new_atte)
    respond_to do |format|
      if @attendance.save
        format.html { redirect_to new_attendance_path, notice: 'CHECK IN' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def new_check_out
    @attendance = @employee.attendances.last
    respond_to do |format|
      if @attendance.update(check_out: DateTime.now)
        format.html { redirect_to new_attendance_path, notice: 'CHECK OUT' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
end
