require 'test_helper'

class AutoScrollControllerTest < ActionDispatch::IntegrationTest
  test "should get article" do
    get auto_scroll_article_url
    assert_response :success
  end

  test "should get post" do
    get auto_scroll_post_url
    assert_response :success
  end

  test "should get user" do
    get auto_scroll_user_url
    assert_response :success
  end

end
