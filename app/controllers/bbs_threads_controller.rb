class BbsThreadsController < ApplicationController
  def new
  end
  
  def show
  end
  
  def index
    @bbs_threads = BbsThread.paginate(page: params[:page])
  end
end
