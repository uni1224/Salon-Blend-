class User::PostsController < ApplicationController
     def index
        @posts = Post.all.page(params[:page]).per(5)
        @comment = Comment.new
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
