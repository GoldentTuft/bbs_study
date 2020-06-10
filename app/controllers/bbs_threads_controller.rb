class BbsThreadsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def show
    @bbs_thread = BbsThread.find(params[:id])
    @user = current_user
    if @user
      @bbs_post = @user.user_posts.build(bbs_thread: @bbs_thread)
      @watch = Watch.find_by(user_id: @user.id, bbs_thread_id: @bbs_thread.id)
    else
      @bbs_post = AnonymousPost.new # (1)
      # @bbs_post = @bbs_thread.anonymous_posts.build # (2)
      password_for_delete =  cookies.permanent.signed[:password_for_delete]
      unless password_for_delete
        password_for_delete = AnonymousPost.new_token
        cookies.permanent.signed[:password_for_delete] = password_for_delete
      end
      @bbs_post.password = password_for_delete
    end
    # puts "----- #{@bbs_thread.anonymous_posts.to_a.count} -----"
    # puts "===== #{@bbs_thread.anonymous_posts.count} ====="
    @all_posts = @bbs_thread.user_posts +  @bbs_thread.anonymous_posts
    @all_posts.sort! do |f,s|
      if !f || !f.created_at
        1
      elsif !s || !s.created_at
        -1
      else
        f.created_at <=> s.created_at
      end
    end
    # @all_posts.sort! do |f,s|
    #   f.created_at <=> s.created_at
    # end
    @all_posts = @all_posts.paginate(page: params[:page])
  end
  
  def index
    if logged_in?
      @bbs_thread = current_user.bbs_threads.build
      @watch_bbs_threads = current_user.watch_bbs_threads
    end
    @bbs_threads = BbsThread.paginate(page: params[:page])
  end
  
  def create
    @bbs_thread = current_user.bbs_threads.build(bbs_thread_params)
    if @bbs_thread.save
      flash[:success] = "Bbs Thread created!"
      redirect_to @bbs_thread
    else
      @bbs_threads = BbsThread.paginate(page: params[:page])
      # redirect_to bbs_threads_url
      render 'index'
    end
  end
  
  def destroy
    @bbs_thread = current_user.bbs_threads.find_by(id: params[:id])
    if @bbs_thread
      @bbs_thread.destroy
      flash[:success] = "Bbs thread deleted"
      redirect_to bbs_threads_url
    else
      redirect_to root_url
    end
  end
  
  private
  
    def bbs_thread_params
      params.require(:bbs_thread).permit(:title, :content)
    end
      
end
