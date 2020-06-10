class WatchesController < ApplicationController
  before_action :logged_in_user
  
  def create
    @user = current_user
    @watch = Watch.new
    @watch.user_id = @user.id
    @watch.bbs_thread_id = params[:bbs_thread_id]
    # @bbs_thread = BbsThread.find_by(id: params[:bbs_thread_id])
    unless @watch.save
      flash[:danger] = 'fail watch'
    end
    # redirect_to request.referrer || root_url
    redirect_back(fallback_location: root_path)
    # redirect_to @bbs_thread
  end
  
  def destroy
    @watch = Watch.find(params[:id])
    @user = current_user
    if @watch && @user
      if @watch.user_id == @user.id
        @watch.destroy
        # flash[:success] = "unfollow"
      end
    end
    # @bbs_thread = BbsThread.find_by(id: @watch.bbs_thread_id)
    # redirect_to request.referrer || root_url
    redirect_back(fallback_location: root_path)
    # redirect_to @bbs_thread
    
  end
end
