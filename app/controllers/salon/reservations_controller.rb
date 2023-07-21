class Salon::ReservationsController < ApplicationController
    def index
        @reservations = Reservation.all
    end

    def show
        @reservation = Reservation.find(params[:id])
    end

    def destroy
        @reservation = Reservation.find_by(params[:id])
    if  @reservation.destroy
         flash[:success] = "予約を削除しました。"
         redirect_to salon_reservations_path(reservation_id)
    else
         render :index
    end
    end

    private


    def reservation_params
        params.require(:reservation).permit(:day, :time, :user_id, :start_time)
    end
end
