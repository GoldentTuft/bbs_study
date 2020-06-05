require 'test_helper'

class AnonymousPostTest < ActiveSupport::TestCase
  def setup
    @bbs_thread = bbs_threads(:godzilla)
    @anonymous_post = @bbs_thread.anonymous_posts.build(
      content: "Lorem ipsum",
      password: "password")
  end
  
  test "should be valid" do
    assert @anonymous_post.valid?
  end
  
  test "content should be present" do
    @anonymous_post.content = "  "
    assert_not @anonymous_post.valid?
  end
  
  test "content should not be too long" do
    @anonymous_post.content = "a" * 5001
    assert_not @anonymous_post.valid?
  end
end
