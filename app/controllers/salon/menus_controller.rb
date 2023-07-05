class Salon::MenusController < ApplicationController
    def index
        @menu = Menu.all
    end

    def show
        @menu = Menu.find(params[:id])
    end

    def new
        @menu = Menu.new
    end

    def create
        @menu = Menu.new(menu_params)
        if @menu.save
            redirect_to salon_menu_path(@menu.id),notice: "メニューの登録が完了しました"
        else
            render :new
        end
    end

    def edit
        @menu = Menu.find(params[:id])
    end

    def update
        @menu = Menu.find(params[:id])
        if @menu.update(menu_params)
            redirect_to salon_menu_path(@menu.id), notice: "メニュー情報が更新されました"
        else
            render :edit
        end
    end

    private
    def menu_params
        params.require(:menu).permit(:title, :body, :image)
    end
end
