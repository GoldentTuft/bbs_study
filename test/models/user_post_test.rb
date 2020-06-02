require 'test_helper'

class UserPostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # @bbs_thread = @user.bbs_threads.build(title: "hoge", content: "Lorem ipsum")
    @bbs_thread = bbs_threads(:godzilla)
    @user_post = @bbs_thread.user_posts.build(content: "Lorem ipsum", user: @user)
  end
  
  test "should be valid" do
    assert @user_post.valid?
  end
  
  test "content should be present" do
    @user_post.content = "  "
    assert_not @user_post.valid?
  end
  
  test "content should not be too long" do
    @user_post.content = "a" * 5001
    assert_not @user_post.valid?
  end
end
