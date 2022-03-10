module EmployeesHelper
    def generate_code()
      Array.new(6){[*"0".."9"].sample}.join
    end

    def secury_data(message)
      format.html { redirect_to employee_url(@employee), notice: message }
      format.json { render :show, status: :created, location: @employee }
    end
end
