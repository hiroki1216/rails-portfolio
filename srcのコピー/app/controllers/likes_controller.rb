class LikesController < ApplicationController

  before_action :user_post
  def create
    liking=current_user.like(user_post)
    current_user.create_notification_like!(user_post.user, user_post)
    if liking.save
      flash[:notice] = '投稿をいいねしました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = '投稿へのいいねに失敗しました'
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    liking=current_user.unlike(user_post)
    if liking.destroy
      flash[:notice] = '投稿へのいいねを解除しました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = '投稿へのいいねの解除に失敗しました'
      redirect_back(fallback_location: root_path)
     end
  end

  private
  def user_post
    @post=Post.find(params[:like][:post_id])
  end



  # def create
  #   Like.create(user_id: current_user.id, post_id: params[:id])
  #   redirect_back(fallback_location: root_path)
  # end

  # def destroy
  #   Like.find_by(user_id: current_user.id, post_id: params[:id]).destroy
  #   redirect_back(fallback_location: root_path)
  # end

end
