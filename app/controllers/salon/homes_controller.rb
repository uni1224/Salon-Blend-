class Salon::HomesController < ApplicationController
     before_action :authenticate_salon!
    def top
    @now = Date.today.month
    @reserve = Reservation.where("created_at >= ?", Date.today)
    @salon = current_salon
    end
end
