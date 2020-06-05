class AnonymousPostsController < ApplicationController
  
  def create
    @bbs_thread = BbsThread.find(params[:bbs_thread_id])
    @anonymous_post = @bbs_thread.anonymous_posts.build(anonymous_post_params)
  
    if @anonymous_post.save
      flash[:success] = "AnonymousPost created!"
      cookies.permanent.signed[:password_for_delete] = params[:anonymous_post][:password]
    else
      flash[:danger] = @anonymous_post.errors.full_messages.join('. ')
    end
      redirect_to request.referrer || root_url
  end

  def destroy
    @anonymous_post = AnonymousPost.find(params[:id])
    if @anonymous_post &&
        @anonymous_post.authenticate(params[:anonymous_post][:password])
      @anonymous_post.destroy
      flash[:success] = "AnonymousPost deleted!"
    else
      flash[:danger] = 'パスワードが違うかも'
      redirect_to request.referrer || root_url
    end
    
  end
  
  def edit
    @anonymous_post = AnonymousPost.find(params[:id])
  end
  
  private
  
    def anonymous_post_params
      params.require(:anonymous_post).permit(:content, :password)
    end
end
