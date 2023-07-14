class Salon::HomesController < ApplicationController
    def top
    @now = Date.today.month
    @reserve = Reservation.all.where(day: Date.current).order("time")
    end
end
