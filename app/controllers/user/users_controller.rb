class User::UsersController < ApplicationController

    def show
        @user= User.find(current_user.id)
    end

    private
    def user_params
    params.require(:user).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :phone_number)
    end
end
