class User::PostsController < ApplicationController
     def index
        @posts = Post.all
     end

     def show
        @post = Post.find(params[:id])
        @comment = Comment.new
        @post_comments = @post.comments
     end
end
