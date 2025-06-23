require "test_helper"

class EnrollmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enrollments_url
    assert_response :success
  end

  test "should get new" do
    get new_enrollment_url
    assert_response :success
  end

  test "should show enrollment" do
    enrollment = enrollments(:one)
    get enrollment_url(enrollment)
    assert_response :success
  end

  test "should get edit" do
    enrollment = enrollments(:one)
    get edit_enrollment_url(enrollment)
    assert_response :success
  end

  test "should create enrollment" do
    assert_difference("Enrollment.count") do
      post enrollments_url, params: { enrollment: { full_price: 100.0, number_of_installments: 5, due_day: 10, course_name: "Curso X", institution_id: institutions(:one).id, student_id: students(:one).id } }
    end
    assert_redirected_to enrollment_url(Enrollment.last)
  end

  test "should update enrollment" do
    enrollment = enrollments(:one)
    patch enrollment_url(enrollment), params: { enrollment: { course_name: "Curso Atualizado" } }
    assert_redirected_to enrollment_url(enrollment)
  end

  test "should destroy enrollment" do
    enrollment = enrollments(:one)
    assert_difference("Enrollment.count", -1) do
      delete enrollment_url(enrollment)
    end
    assert_redirected_to enrollments_url
  end
end
