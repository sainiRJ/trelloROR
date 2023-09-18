require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get employees_new_url
    assert_response :success
  end

  test "should get create" do
    get employees_create_url
    assert_response :success
  end

  test "should get index" do
    get employees_index_url
    assert_response :success
  end

  test "should get login" do
    get employees_login_url
    assert_response :success
  end
end
