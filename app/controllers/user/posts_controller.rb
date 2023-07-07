class User::PostsController < ApplicationController
     def index
        @posts = Post.all
        @salon = Salon.find_by(params[:id])
     end
    
     def show
        @post = Post.find(params[:id])
     end
end
