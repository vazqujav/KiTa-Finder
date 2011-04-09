require 'test_helper'

class KitasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kitas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kita" do
    assert_difference('Kita.count') do
      post :create, :kita => { }
    end

    assert_redirected_to kita_path(assigns(:kita))
  end

  test "should show kita" do
    get :show, :id => kitas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => kitas(:one).to_param
    assert_response :success
  end

  test "should update kita" do
    put :update, :id => kitas(:one).to_param, :kita => { }
    assert_redirected_to kita_path(assigns(:kita))
  end

  test "should destroy kita" do
    assert_difference('Kita.count', -1) do
      delete :destroy, :id => kitas(:one).to_param
    end

    assert_redirected_to kitas_path
  end
end
