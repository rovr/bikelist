require 'test_helper'

class BikesControllerTest < ActionController::TestCase
  setup do
    @bike = bikes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bike" do
    assert_difference('Bike.count') do
      post :create, params: { bike: {  } }
    end

    assert_redirected_to bike_path(Bike.last)
  end

  test "should show bike" do
    get :show, params: { id: @bike }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @bike }
    assert_response :success
  end

  test "should update bike" do
    patch :update, params: { id: @bike, bike: {  } }
    assert_redirected_to bike_path(@bike)
  end

  test "should destroy bike" do
    assert_difference('Bike.count', -1) do
      delete :destroy, params: { id: @bike }
    end

    assert_redirected_to bikes_path
  end
end
