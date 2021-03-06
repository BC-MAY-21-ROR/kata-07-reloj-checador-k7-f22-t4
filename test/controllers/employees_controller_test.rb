require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference("Employee.count") do
      post employees_url, params: { employee: { active: @employee.active, branch_id: @employee.branch_id, email: @employee.email, name: @employee.name, position: @employee.position, private_code: @employee.private_code } }
    end

    assert_redirected_to employee_url(Employee.last)
  end

  test "should show employee" do
    get employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { active: @employee.active, branch_id: @employee.branch_id, email: @employee.email, name: @employee.name, position: @employee.position, private_code: @employee.private_code } }
    assert_redirected_to employee_url(@employee)
  end

end
