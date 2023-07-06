class User::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_current_user

  def show
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

  private

  def set_current_user
    @user = current_user
  end
    private
    def user_params
    params.require(:user).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :phone_number)
    end
end
