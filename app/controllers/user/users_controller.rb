class User::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_current_user

  def show
    @user_reservations = current_user.reservation.where("start_time >= ?", DateTime.current).order(day: :desc)
    @visit_historys = current_user.reservation.where("start_time < ?", DateTime.current).where("start_time > ?", DateTime.current << 12).order(day: :desc)
  end

  def edit
  end

  def update
     if @user.update(user_params)
      redirect_to mypage_path, success: '会員情報の更新が完了しました。'
     else
      render :edit
     end
  end

  def quit
  end

  def out
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
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
