class Salon::SalonsController < ApplicationController
     def show
        @salon= Salon.find(current_salon.id)
     end

     def new
        @salon = Salon.new
     end

     def create
        @salon = Salon.find(params[:id])
        @salon.save

     end
     
     def update
        @salon = Salon.find(current_salon.id)
        @salon.update(salon_params)
        redirect_to salons_mypage_path
        flash[:notice] = "変更が完了しました"
     end


    private
    def salon_params
    params.require(:salon).permit(:name, :introduction, :email, :postal_code, :address, :phone_number)
    end
end
