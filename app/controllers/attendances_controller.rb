class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[show edit update destroy]
  before_action :authenticate_admin!, except: %i[new create]

  # GET /attendances or /attendances.json
  def index
    prueba = Date.today
    prueba =  Date.parse(params[:day]) if !params[:day].nil?
    @attendances = Attendance.attendance_by_day(prueba)
    @absences = Attendance.absence_list(Date.parse("#{params[:absence_month]}-01"))
    @avg_month = Date.parse("#{params[:avg_month]}-01")
  end

  # GET /attendances/1 or /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  def check
  end

  # POST /attendances or /attendances.json
  def create
    @employee = Employee.find_by(private_code: attendance_params[:employee_id])
    if @employee && !helpers.check_complete? then new_check_in
    elsif @employee && helpers.check_complete? then new_check_out
    else redirect_to new_attendance_path, alert: "Employee doesn't exist"
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
