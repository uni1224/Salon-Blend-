class Salon::PostsController < ApplicationController
    before_action :authenticate_salon!
    def index
        @posts = Post.all.order(created_at:"desc").page(params[:page]).per(5)
    end

    def show
        @post = Post.find(params[:id])
        @comment = Comment.new
        @post_comments = @post.comments
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        tags = Vision.get_image_data(post_params[:image])
        if @post.save
            tags.each do |tag|
             @post.tags.create(name: tag)
             end
             flash[:success] =  "投稿が完了しました"
            redirect_to salon_post_path(@post.id)
        else
            flash.now[:danger] = "投稿に失敗しました"
            render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            flash[:success] =  "投稿を編集しました"
            redirect_to salon_post_path(@post)
        else
            flash.now[:danger] = "編集に失敗しました"
            render :edit
        end
    end

    def destroy
        post = Post.find(params[:id])
        post.destroy
        flash[:success] = "投稿を削除しました"
        redirect_to salon_posts_path
    end


     private
     def post_params
         params.require(:post).permit(:title, :body, :image)
     end
end
