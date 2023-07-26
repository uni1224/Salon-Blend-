class Salon::MessagesController < ApplicationController
    before_action :authenticate_salon!
   def create
      message = Message.new(message_params)
    if message.save
      flash[:success] = 'メッセージを送信しました'
      redirect_to salon_room_path(message.room.reservation_id)
    else
       flash[:danger] = 'メッセージを送信できませんでした'
      redirect_to salon_room_path(message.room.reservation_id)
    end
   end

  private
  
    def message_params
      params.require(:message).permit(:message, :room_id).merge(salon_id: current_salon.id)
    end
end
