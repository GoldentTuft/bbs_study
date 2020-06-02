require 'test_helper'

class UserPostsControllerTest < ActionDispatch::IntegrationTest

  def setup
  end

  test "destroy" do
    log_in_as(users(:michael))
    assert_difference 'UserPost.count', -1 do
      delete user_post_path(user_posts(:kakiko1))
    end
  end
  
  test "should fail destroy when not logged in" do
    assert_no_difference 'UserPost.count' do
      delete user_post_path(user_posts(:kakiko1))
    end
  end
  
  test "should fail destroy for defferent user's post " do
    log_in_as(users(:archer))
    assert_no_difference 'UserPost.count' do
      delete user_post_path(user_posts(:kakiko1))
    end
  end
  
  test "create" do
    log_in_as(users(:michael))
    assert_difference 'UserPost.count', 1 do
      post user_posts_path, params: {
        bbs_thread_id: bbs_threads(:godzilla).id,
        user_post: {
          user_id: users(:michael).id,
          content: "hoge"
      } }
    end
  end
  
  test "chould fail create when not logged in" do
    assert_no_difference 'UserPost.count' do
      post user_posts_path, params: {
        bbs_thread_id: bbs_threads(:godzilla).id,
        user_post: {
          user_id: users(:michael).id,
          content: "hoge"
      } }
    end
  end

end
