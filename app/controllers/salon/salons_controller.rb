class Salon::SalonsController < ApplicationController
  before_action :authenticate_salon!
  before_action :set_current_salon

  def show
  end

  def edit
  end

  def update
      if @salon.update(salon_params)
      redirect_to salon_mypage_path, notice: '会員情報の更新が完了しました。'
      else
      render :edit
      end
  end

  def unsubscribe
  end

  def withdraw
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
