require 'test_helper'

class BbsThreadsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @bbs_thread = bbs_threads(:godzilla)
  end

  test "should redirect create when not logged in" do
    # log_in_as(users(:michael))
    assert_no_difference 'BbsThread.count' do
      post bbs_threads_path, params: { bbs_thread: {
        title: 'hoge',
        content: 'hoge' } }
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    # log_in_as(users(:michael))
    assert_no_difference 'BbsThread.count' do
      delete bbs_thread_path(@bbs_thread)
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong bbs_thread" do
    log_in_as(users(:michael))
    other_bbs_thread = bbs_threads(:radon)
    assert_no_difference 'BbsThread.count' do
      delete bbs_thread_path(other_bbs_thread)
    end
    assert_redirected_to root_url
  end
  
  
end
