class StaticPagesController < ApplicationController

  def about
  end

  def hello
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def contact
  end
end
