class NotificationsController < ApplicationController

  def index

    #男と女で表示は切り替わる
      #current_userに関わるuserlikesをとってきて
      #時系列順に並べて@notificationsにいれる
      #view側でmatchingのstatusをみてif分岐する
      @notifications = Userike.where(:like_id => current_user.id).where.not(:matching => 0)


  end

end
