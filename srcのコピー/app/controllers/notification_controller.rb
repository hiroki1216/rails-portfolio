class NotificationController < ApplicationController
 
  def index
    @notifications=Notification.where(visited_id: current_user.id)
    @notifications.where(checked: false).update_all(checked: true)  
  end

end
