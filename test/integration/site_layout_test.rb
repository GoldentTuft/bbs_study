require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "layout links" do
    get root_path
    assert_template 'bbs_threads/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", about_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    assert_select 'form[action="/signup"]'
  end
  
  test "layout links when logged in" do
    log_in_as(@user)
    get root_path
    assert_template 'bbs_threads/index'
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
  end
end
