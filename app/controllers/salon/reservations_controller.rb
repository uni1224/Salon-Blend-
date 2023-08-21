class Salon::ReservationsController < ApplicationController
  before_action :authenticate_salon!
  def index
    @reservations = Reservation.all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    @reservation = Reservation.find_by(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      flash[:success] = '予約を変更しました'
      redirect_to salon_reservation_path(@reservation)
    else
      flash.now[:danger] = '変更に失敗しました'
      render :edit
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      flash[:success] = '予約を削除しました'
      redirect_to salon_reservations_path(@reservation)
    else
      flash[:success] = '予約の削除に失敗しました'
      render :index
    end
  end

  def update_status
    @reservation = Reservation.find(params[:id])
    new_status = params[:new_status]

    if @reservation.update(status: new_status)
      flash[:success] = 'ステータスを更新しました'
    else
      flash[:danger] = 'ステータスの更新に失敗しました'
    end

    redirect_to salon_reservation_path(@reservation)
  end

  private

  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :start_time)
  end
end
