class Salon::SalonsController < ApplicationController
  before_action :authenticate_salon!
  before_action :set_current_salon

  def show
  end

  def edit
  end

  def update
      if @salon.update(salon_params)
        flash[:success] = 'サロン情報を更新しました'
      redirect_to salon_mypage_path 
      else
        flash[:danger] = 'サロン情報の更新に失敗しました'
      render :edit
      end
  end

  def quit
  end

  def out
  end

  private

  def set_current_salon
    @salon = current_salon
  end
    private
    def salon_params
    params.require(:salon).permit(:name, :introduction, :email, :postal_code, :address, :phone_number)
    end
end
