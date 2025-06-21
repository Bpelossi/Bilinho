require "test_helper"

class InstitutionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get institutions_index_url
    assert_response :success
  end

  test "should get show" do
    get institutions_show_url
    assert_response :success
  end

  test "should get new" do
    get institutions_new_url
    assert_response :success
  end

  test "should get create" do
    get institutions_create_url
    assert_response :success
  end

  test "should get edit" do
    get institutions_edit_url
    assert_response :success
  end

  test "should get update" do
    get institutions_update_url
    assert_response :success
  end

  test "should get destroy" do
    get institutions_destroy_url
    assert_response :success
  end
end
