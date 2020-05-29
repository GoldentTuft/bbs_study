require 'test_helper'

class BbsThreadsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bbs_threads_url
    assert_response :success
  end

end
