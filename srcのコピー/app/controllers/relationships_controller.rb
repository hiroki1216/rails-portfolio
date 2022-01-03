class RelationshipsController < ApplicationController
    before_action :user
    def create
       following = current_user.follow(user)
       if following.save
         current_user.create_notification_following!(user)
         flash[:notice] = 'ユーザーをフォローしました'
         redirect_back(fallback_location: root_path)
       else
         flash.now[:alert] = 'ユーザーのフォローに失敗しました'
         redirect_back(fallback_location: root_path)
       end
    end

    def destroy
       following = current_user.unfollow(user)
       if following.destroy
         flash[:notice] = 'ユーザーのフォローを解除しました'
         redirect_back(fallback_location: root_path)
       else
         flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
         redirect_back(fallback_location: root_path)
        end
    end

    private

    def user
      @user = User.find(params[:relationship][:followee_id])
    end
    
end
