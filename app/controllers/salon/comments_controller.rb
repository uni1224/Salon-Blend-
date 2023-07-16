class Salon::CommentsController < ApplicationController
     def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.salon_id = current_salon.id
    @comment.post_id = @post.id
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

  def comment_params
    params.require(:comment).permit(:content)
  end
end
