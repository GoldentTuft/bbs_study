require 'test_helper'

class AnonymousPostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @tokumei_kakiko1 = anonymous_posts(:tokumei_kakiko1)
    @tokumei_kakiko2 = anonymous_posts(:tokumei_kakiko2)
  end
  
  test "destroy" do
    assert_difference 'AnonymousPost.count', -1 do
      delete anonymous_post_path(@tokumei_kakiko1), params: {
        anonymous_post: {
          password: 'password'
        }
      }
    end
  end
  
  test "should fail destroy when password is defferent" do
    assert_no_difference 'AnonymousPost.count' do
      delete anonymous_post_path(@tokumei_kakiko1), params: {
        anonymous_post: {
          password: 'foobar'
        }
      }
    end
  end
  
  test "create" do
    assert_difference 'AnonymousPost.count', 1 do
      post anonymous_posts_path, params: {
        bbs_thread_id: bbs_threads(:godzilla).id,
        anonymous_post: {
          content: "hoge",
          password: "password"
        }
      }
    end
  end
  
end
