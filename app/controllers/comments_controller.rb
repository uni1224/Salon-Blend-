class CommentsController < ApplicationController
   def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post.id)
   end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_comment_path(params[:post_id])
  end
end
