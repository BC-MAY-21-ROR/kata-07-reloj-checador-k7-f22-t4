# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Branch.create(name: 'Human Resources', address: 'Av. Tecnologico')
Branch.create(name: 'Finances', address: 'Tercer Anillo Periferico')
Branch.create(name: 'Systems', address: 'Nowhere')

Employee.create(name: 'Marco Polo', email: 'example@gmail.com', private_code: '325353', branch_id: 1)
Employee.create(name: 'Aurelio Gómez', email: 'example@outlook.com', private_code: '908731', branch_id: 1)
Employee.create(name: 'Samuel De Luque', email: 'example@hotmail.com', private_code: '312315', branch_id: 1)
Employee.create(name: 'Guillermo Diaz', email: 'example@live.com', private_code: '876543', branch_id: 1)

7.times do |month| 
  4.times do |employee| 
    13.times do | day | 
      Attendance.create(check_in: (DateTime.now - day.days - month.months), check_out: DateTime.now - day.days + 2.hours - month.months, employee_id: employee + 1)
    end
  end
end
