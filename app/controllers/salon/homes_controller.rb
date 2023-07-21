class Salon::HomesController < ApplicationController
    def top
    @now = Date.today.month
    @reserve = Reservation.where("created_at >= ?", Date.today)
    end
end
