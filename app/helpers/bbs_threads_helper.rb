module BbsThreadsHelper
  
  def link_to_last_post(title, bbs_thread)
    res = bbs_thread_path(bbs_thread.id)
    
    pc = bbs_thread.page_count
    if pc > 1
      res += "?page=" + pc.to_s
    end
    
    lp = bbs_thread.last_post
    if lp
      res += "#post-" + lp.post_number.to_s
    end
    return link_to(title, res)
  end
end
