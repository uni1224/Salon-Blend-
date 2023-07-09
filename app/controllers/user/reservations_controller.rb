class User::ReservationsController < ApplicationController
    def index
    @reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
    end

    def new
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
    @menu = Menu.find_by(params[:id])
    @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
    message = Reservation.check_reservation_day(@day.to_date)
    if !!message
      redirect_to @reservation, flash: { alert: message }
    end
    end

    def show
    @reservation = Reservation.find(params[:id])
    end

    def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to reservation_path @reservation.id
    else
      render :new
    end
    end


  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      flash[:success] = "予約を削除しました。"
      redirect_to salon_reservation_path(reservation_id)
    else
      render :show
    end
  end


  private
  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :menu_id, :start_time)
  end
end
