class User::HomesController < ApplicationController
    def top
    end
    def about
        @salon = Salon.find_by(params[:id])
    end
end
