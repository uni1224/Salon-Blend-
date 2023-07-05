class User::UsersController < ApplicationController

    def show
        @user= User.find(current_user.id)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.find(params[:id])
        @user.save
    end
    
    def edit
        @user = User.find(current_user.id)
    end

     def update
        @user = User.find(current_user.id)
        @user.update(user_params)
        redirect_to users_mypage_path
        flash[:notice] = "変更が完了しました"
     end


    private
    def user_params
    params.require(:user).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :phone_number)
    end
end
