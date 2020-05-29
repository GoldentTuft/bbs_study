require 'test_helper'

class BbsThreadTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @bbs_thread = BbsThread.new(title: "hoge", content: "Lorem ipsum")
  end
  
  test "should be valid" do
    assert @bbs_thread.valid?
  end
  
  test "title should be present" do
    @bbs_thread.title = "  "
    assert_not @bbs_thread.valid?
  end
  
  test "content should be present" do
    @bbs_thread.content = "  "
    assert_not @bbs_thread.valid?
  end
  
  test "title should not be too long" do
    @bbs_thread.title = "a" * 51
    assert_not @bbs_thread.valid?
  end
  
  test "content should not be too long" do
    @bbs_thread.content = "a" * 5001
    assert_not @bbs_thread.valid?
  end
end
