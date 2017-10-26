require 'test_helper'

class AlbumControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get album_new_url
    assert_response :success
  end

  test "should get create" do
    get album_create_url
    assert_response :success
  end

  test "should get destroy" do
    get album_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get album_edit_url
    assert_response :success
  end

end
