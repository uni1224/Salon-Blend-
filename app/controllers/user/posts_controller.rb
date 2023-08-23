class User::PostsController < ApplicationController
  def index
    @comment = Comment.new
    if params[:latest]
      @posts = Post.latest.page(params[:page]).per(5)
    elsif params[:old]
      @posts = Post.old.page(params[:page]).per(5)
    elsif params[:like_count]
      @posts = Post.left_joins(:likes).group(:id).order('COUNT(likes.id) DESC').page(params[:page]).per(5)
    else
      @posts = Post.all.order(created_at: 'desc').page(params[:page]).per(5)
    end
  end

  def show
    @post = Post.find(params[:id])
    unless ReadCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user.id, post_id: @post.id)
      current_user.read_counts.create(post_id: @post.id)
    end
    @comment = Comment.new
    @post_comments = @post.comments
  end
end
