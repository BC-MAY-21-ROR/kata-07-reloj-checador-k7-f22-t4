module EmployeesHelper
    def generate_code()
      Array.new(6){[*"0".."9"].sample}.join
    end
end
