class CommentsController < ApplicationController
    before_action :user_post
    def create
        @comment = current_user.comments.new(comment_params)
        if @comment.save
          current_user.create_notification_comment!(user_post.user, @comment, user_post)
          redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
        else
          redirect_back(fallback_location: root_path)  #同上
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:comment_content, :post_id)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
    end

    def user_post
      @post=Post.find_by(id: params[:comment][:post_id])
    end

end
