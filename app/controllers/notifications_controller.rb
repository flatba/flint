class NotificationsController < ApplicationController

  def index
      @notifications = UserLike.where(["like_id = ? or user_id = ?", current_user.id, current_user.id])
  end

end
