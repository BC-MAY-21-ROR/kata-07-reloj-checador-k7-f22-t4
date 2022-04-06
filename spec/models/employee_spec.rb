require 'rails_helper'

describe Employee do
  before(:each) do
    @employee = Employee.new(name: 'Jorge', email: 'jorge@gmail.com', position: 'Chalan', private_code: '123456', active: true, branch_id: Branch.last.id)
  end

  it 'is valid create with all fields values' do
    expect(@employee).to be_valid
  end

  it 'Name field should have presence' do
    @employee.name = nil
    expect(@employee).not_to be_valid
  end

  it 'Email field should have presence' do
    @employee.email = nil
    expect(@employee).not_to be_valid
  end

  it 'Position field should have presence' do
    @employee.position = nil
    expect(@employee).not_to be_valid
  end

  it 'private_code field should have presence' do
    @employee.private_code = nil
    expect(@employee).not_to be_valid
  end

  it 'Active field should have presence' do
    @employee.active = nil
    expect(@employee).not_to be_valid
  end

  it 'Branch_id field should have presence' do
    @employee.branch_id = nil
    expect(@employee).not_to be_valid
  end

  it 'Email must be unique' do 
    @employee.save!
    employee2 = Employee.new(name: 'Jorge', email: 'jorge@gmail.com', position: 'QA Tester', private_code: '534623', active: true, branch_id: Branch.last.id)
    expect(employee2).not_to be_valid
  end

  it 'Private_code must be unique' do 
    @employee.save!
    employee3 = Employee.new(name: 'Raul', email: 'Raul@gmail.com', position: 'Cocinero', private_code: '123456', active: true, branch_id: Branch.last.id)
    expect(employee3).not_to be_valid
  end

  it 'Private_code should have 6 characters' do
    @employee.private_code = '12345'
    expect(@employee).not_to be_valid
  end
end
