class NotificationsController < ApplicationController
    before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications.includes(:visitor, :comment, :post)
    @notification = Notification.find_by(id: params[:id])
    @notification = @notification.decorate if @notification.present?
      @notifications.update(checked: true)
  end

  def update
    notification = Notification.find(params[:id])
    if notification.update(checked: true)
      redirect_to notifications_path
    end
  end

  def destroy
    @notification = Notification.find(paras[:id])
    @notification.destroy
    
    respond_to do |format|
      format.js
  end
  end
end
