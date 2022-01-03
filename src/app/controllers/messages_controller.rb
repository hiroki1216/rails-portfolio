class MessagesController < ApplicationController
  before_action :other_users, only: [:create]
  def create
    @message=Message.new(message_params)
    if @message.save
      #ログインユーザー以外のトークに参加しているユーザーに対してメッセージ通知を作成する。
      @other_users.each do |other_user|
        current_user.create_notification_message!(other_user, @message)
      end
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message=Message.find_by(id: params[:id])
    if @message.destroy
      redirect_back(fallback_location: root_path)
    elses
      redirect_back(fallback_location: root_path)
    end
  end
end

private

def message_params
  params.require(:message).permit(:content, :talk_id, :user_id)
end

#ログインユーザー以外のトークに参加しているユーザーを取得。
def other_users
  talk=Talk.find_by(id: params[:talk_id])
  @other_users=talk.members.where.not(id: current_user.id)
end