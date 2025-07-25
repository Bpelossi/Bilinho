require "test_helper"

class InstitutionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get institutions_url
    assert_response :success
  end

  test "should get new" do
    get new_institution_url
    assert_response :success
  end

  test "should show institution" do
    institution = institutions(:one)
    get institution_url(institution)
    assert_response :success
  end

  test "should get edit" do
    institution = institutions(:one)
    get edit_institution_url(institution)
    assert_response :success
  end

  test "should create institution" do
    assert_difference("Institution.count") do
      post institutions_url, params: { institution: { name: "Test", cnpj: "123456", institution_type: "school" } }
    end
    assert_redirected_to institution_url(Institution.last)
  end

  test "should update institution" do
    institution = institutions(:one)
    patch institution_url(institution), params: { institution: { name: "Updated Name" } }
    assert_redirected_to institution_url(institution)
  end

  test "should destroy institution" do
    institution = institutions(:one)
    assert_difference("Institution.count", -1) do
      delete institution_url(institution)
    end
    assert_redirected_to institutions_url
  end
end
