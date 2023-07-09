class Salon::ReservationsController < ApplicationController
    def index
        @reservations = Reservation.all
        @reservation = Reservation.find_by(params[:id])
    end
    
    
end
