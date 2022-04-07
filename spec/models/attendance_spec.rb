require 'rails_helper'

describe Attendance do
  context 'calculating effective days in the current year (2022)' do
    it 'validates effective days in January' do
      date = Date.parse('01/01/2022')
      effective_days = Attendance.efective_day(date)
      expect(effective_days).to eq 21
    end

    it 'validates effective days in February' do
      date = Date.parse('01/02/2022')
      effective_days = Attendance.efective_day(date)
      expect(effective_days).to eq 20
    end

    it 'validates effective days in March' do
      date = Date.parse('01/03/2022')
      effective_days = Attendance.efective_day(date)
      expect(effective_days).to eq 23
    end
  end

  context 'calculating effective days in others years' do
    it 'validates effective days in October of 2019 ' do
      date = Date.parse('01/10/2019')
      effective_days = Attendance.efective_day(date)
      expect(effective_days).to eq 23
    end

    it 'validates effective days in May of 2020' do
      date = Date.parse('01/05/2020')
      effective_days = Attendance.efective_day(date)
      expect(effective_days).to eq 21
    end

    it 'validates effective days in July of 2021' do
      date = Date.parse('01/07/2021')
      effective_days = Attendance.efective_day(date)
      expect(effective_days).to eq 22
    end
  end

  context 'calculating avarage time of check_in and check_out by month' do
    before(:each) do
      Attendance.new(employee_id: '980190962', check_in: 'Thu, 07 Apr 2022 16:15:00 -0500', check_out:'Thu, 07 Apr 2022 22:48:00 -0500').save!
      Attendance.new(employee_id: '980190962', check_in: 'Thu, 08 Apr 2022 18:30:00 -0500', check_out:'Thu, 08 Apr 2022 20:13:00 -0500').save!
      Attendance.new(employee_id: '980190962', check_in: 'Thu, 09 Apr 2022 12:30:00 -0500', check_out:'Thu, 09 Apr 2022 21:50:00 -0500').save!
      Attendance.new(employee_id: '980190962', check_in: 'Thu, 10 Apr 2022 10:45:00 -0500', check_out:'Thu, 10 Apr 2022 23:55:00 -0500').save!
    end

    it 'validates check in average' do
      average = Attendance.average_check_time_by_month(Date.parse('april'), true)
      expect(average).to eq ' 2:30'
    end

    it 'validates check out average' do
      average = Attendance.average_check_time_by_month(Date.parse('april'), false)
      expect(average).to eq '10:11'
    end
  end
end
