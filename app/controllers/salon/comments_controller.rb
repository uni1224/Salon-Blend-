class Salon::CommentsController < ApplicationController
  before_action :authenticate_salon!
  def index
    @comments = Comment.page(params[:page]).per(10)
    @post = Post.find_by(params[:id])
  end

  def show
    @comment = Comment.find(params[:id])
    @post = Post.find_by(params[:id])
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to salon_comments_path(params[:post_id]), notice: '不適切なコメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
