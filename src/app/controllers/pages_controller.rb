class PagesController < ApplicationController
  # before_action :sign_in_required, only: [:show, :index]
  before_action :authenticate_user!, only: [:show, :index]
  before_action :find_target_talk, only: [:followings]

  def home
  end

  def index
    @users=User.all
  end

  def show
    @posts=current_user.posts
    @like_posts=current_user.like_posts  
    @following_users=current_user.followings
  end

  def followings
    @user=User.find(params[:id])
    @posts=@user.posts
    @like_posts=@user.like_posts
    @following_users=@user.followings
  end

  def find_target_talk
    #current_userのトークを全件取得
    @current_users_talks=current_user.talks
    #トークの中でフォロー中のユーザとのトークが存在するかを確認
    @current_users_talks.each do |current_users_talk|
      if current_users_talk.members.find_by(id: params[:id])
        @target_talk=current_users_talk
      end
    end

    if  @target_talk.present?
      @messages=@target_talk.messages
      @message=Message.new
    else
      @talk=Talk.new
    end
  
  end

end
