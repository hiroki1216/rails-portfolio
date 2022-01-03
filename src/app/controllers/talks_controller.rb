class TalksController < ApplicationController
  before_action :authenticate_user! 
  before_action :target_user, only: [:create]

  def show
    @talk=Talk.find_by(id: params[:id])
    @members=@talk.members
    @message = Message.new
    @messages = @talk.messages
  end

  def create
    #自分のトーク履歴
    entry=current_user.entry(@talk)
    #相手のトーク履歴
    reverse_entry=@target_user.entry(@talk)
    redirect_to @talk
  end


  private
    #トーク相手の取得
    def target_user
      @target_user=User.find_by(id: params[:talk][:user_id])
      @talk=Talk.new
      @talk.save
    end

    
end
