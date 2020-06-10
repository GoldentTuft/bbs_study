require 'test_helper'

class WatchTest < ActiveSupport::TestCase
  def setup
    @watch = Watch.new(
      user_id: users(:michael).id,
      bbs_thread_id: bbs_threads(:godzilla).id)
  end
  
  test "should be valid" do
    assert @watch.valid?
  end
  
  test "should require a user_id" do
    @watch.user_id = nil
    assert_not @watch.valid?
  end
  
  test "should require a bbs_thread_id" do
    @watch.bbs_thread_id = nil
    assert_not @watch.valid?
  end
end
