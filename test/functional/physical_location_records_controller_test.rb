require 'test_helper'

class PhysicalLocationRecordsControllerTest < ActionController::TestCase
  setup do
    @physical_location_record = physical_location_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:physical_location_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create physical_location_record" do
    assert_difference('PhysicalLocationRecord.count') do
      post :create, :physical_location_record => @physical_location_record.attributes
    end

    assert_redirected_to physical_location_record_path(assigns(:physical_location_record))
  end

  test "should show physical_location_record" do
    get :show, :id => @physical_location_record.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @physical_location_record.to_param
    assert_response :success
  end

  test "should update physical_location_record" do
    put :update, :id => @physical_location_record.to_param, :physical_location_record => @physical_location_record.attributes
    assert_redirected_to physical_location_record_path(assigns(:physical_location_record))
  end

  test "should destroy physical_location_record" do
    assert_difference('PhysicalLocationRecord.count', -1) do
      delete :destroy, :id => @physical_location_record.to_param
    end

    assert_redirected_to physical_location_records_path
  end
end
