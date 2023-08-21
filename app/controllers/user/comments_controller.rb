class User::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:destroy]
  def create
    @post = Post.find(params[:post_id])
    @post_comments = @post.comments
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @comment.score = Language.get_comment(comment_params[:content])
    @comment.save
    flash[:success] = 'コメントしました'
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comments = @post.comments
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました'
  end

  private

  def ensure_correct_user
    @comment = Comment.find(params[:id])
    return if @comment.user == current_user

    redirect_to posts_path, notice: '投稿者以外コメントは削除できません。'
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
