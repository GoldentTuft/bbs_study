class UserPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @bbs_thread = BbsThread.find(params[:bbs_thread_id])
    @user_post = UserPost.new(user_post_params)
    @user_post.user_id = current_user.id

  
    if @bbs_thread.push_post(@user_post)
      flash[:success] = "UserPost created!"
    else
      flash[:danger] = @user_post.errors.full_messages.join(', ')
    end
      redirect_to request.referrer || root_url
  end

  def destroy
    @user_post = current_user.user_posts.find_by(id: params[:id])
    if @user_post
      @user_post.destroy
      flash[:success] = "UserPost deleted"
    end
    redirect_to request.referrer || root_url
  end
  
  private
  
    def user_post_params
      params.require(:user_post).permit(:content)
    end
end
