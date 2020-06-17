require 'test_helper'

class BbsThreadsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @bbs_thread = bbs_threads(:godzilla)
    @watch = watches(:michael_watch)
  end
  
  test "bbs_thread interface" do
    log_in_as(@user)
    get bbs_threads_url
    assert_select 'div.pagination'
    # 自分の作ったスレッドで削除ボタンがあることを確認
    get bbs_thread_path(bbs_threads(:godzilla))
    assert_select 'a', text: 'delete'
    # 自分以外の作ったスレッドで削除ボタンがないことを確認
    get bbs_thread_path(bbs_threads(:radon))
    assert_select 'a', text: 'delete', count: 0
  end
  
  test "follow and unfollow" do
    log_in_as(@user)
    assert_difference "@bbs_thread.followers.count", -1 do
      delete watch_path(@watch)
    end
    assert_difference "@bbs_thread.followers.count", 1 do
      post watches_path, params: { bbs_thread_id: @bbs_thread.id }
    end
  end 
end
