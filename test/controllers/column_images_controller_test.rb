require 'test_helper'

class ColumnImagesControllerTest < ActionController::TestCase
  setup do
    @column_image = column_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:column_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create column_image" do
    assert_difference('ColumnImage.count') do
      post :create, column_image: { column_id: @column_image.column_id, descrizione: @column_image.descrizione }
    end

    assert_redirected_to column_image_path(assigns(:column_image))
  end

  test "should show column_image" do
    get :show, id: @column_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @column_image
    assert_response :success
  end

  test "should update column_image" do
    patch :update, id: @column_image, column_image: { column_id: @column_image.column_id, descrizione: @column_image.descrizione }
    assert_redirected_to column_image_path(assigns(:column_image))
  end

  test "should destroy column_image" do
    assert_difference('ColumnImage.count', -1) do
      delete :destroy, id: @column_image
    end

    assert_redirected_to column_images_path
  end
end
