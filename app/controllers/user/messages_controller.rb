class User::MessagesController < ApplicationController
     before_action :authenticate_user!
    def create
       message = Message.new(message_params)
    if message.save
        flash[:success] = 'メッセージを送信しました'
       redirect_to room_path(message.room.reservation_id)
    else
        flash[:danger] = 'メッセージを送信できませんでした'
      redirect_to room_path(message.room.reservation_id)
    end
    end

  private

    def message_params
        params.require(:message).permit(:message, :room_id).merge(user_id: current_user.id)
    end
end
