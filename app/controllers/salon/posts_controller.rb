class Salon::PostsController < ApplicationController
    def index
        @post = Post.all
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end

    def create
       @post = Post.new(post_params)
        if @post.save
            redirect_to salon_post_path(@post.id),notice: "投稿が完了しました"
        else
            render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to salon_post_path(post.id),notice: "編集が完了しました"
        else
            render :edit
        end
    end

     private
     def post_params
         params.require(:post).permit(:title, :body, :image)
     end
end
