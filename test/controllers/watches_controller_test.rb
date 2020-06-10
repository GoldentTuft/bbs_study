require 'test_helper'

class WatchesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @watch = watches(:michael_watch)
  end

  test "destroy" do
    log_in_as(users(:michael))
    assert_difference 'Watch.count', -1 do
      delete watch_path(@watch)
    end
  end
  
  test "destroy should require logged-in user" do
    assert_no_difference 'Watch.count' do
      delete watch_path(@watch)
    end
  end
  
  test "destroy should require correct user" do
    log_in_as(users(:archer))
    assert_no_difference 'Watch.count' do
      delete watch_path(@watch)
    end
  end
  
  test "create" do
    log_in_as(users(:michael))
    assert_difference 'Watch.count', 1 do
      post watches_path, params: {
        bbs_thread_id: bbs_threads(:gamera).id
      }
    end
  end
  
  test "create should require logged-in user" do
    assert_no_difference 'Watch.count' do
      post watches_path, params: {
        bbs_thread_id: bbs_threads(:gamera).id
      }
    end
  end
  
  # test "create should require unique" do
  #   log_in_as(users(:michael))
  #   assert_difference 'Watch.count', 1 do
  #     post watches_path, params: {
  #       bbs_thread_id: bbs_threads(:gamera).id
  #     }
  #     post watches_path, params: {
  #       bbs_thread_id: bbs_threads(:gamera).id
  #     }
  #   end
  # end
end
