class PostsController < ApplicationController

    before_action :authenticate_user! 

    def index
        @posts=Post.all
    end

    def show
        @comment = Comment.new 
        @comments=Comment.where(post_id: params[:id])
        @post = Post.find(params[:id])
        @users=@post.users
    end

    def new
        @post=current_user.posts.new
        #以下は上記のように書き換えられる
        # @post=Post.new
        # @post.user_id=current_user.id
        @categories=Category.all
    end
    
    def create
        @categories=Category.all
        @post=current_user.posts.new(post_params)
        #以下は上記のように書き換えられる
        # @post=Post.new(post_params)
        # @post.user_id=current_user.id
        @post.category_id=params[:category][:name]
        

        if @post.save
            redirect_to  post_path(@post), notice: '投稿に成功しました。'
        else
            render :new
        end

    end

    def edit
        @post = Post.find(params[:id])
        @categories=Category.all
    end

    def update
        @categories=Category.all
        @post=Post.find(params[:id])
        if @post.update(title: post_params[:title],contents: post_params[:contents],category_id: params[:category][:name])
             redirect_to post_path, notice: '更新に成功しました。'
        else
            render :edit  
        end   
    end

    def destroy
        @post = Post.find(params[:id])
        if @post.destroy
            redirect_to pages_show_path
        else
            render :show
        end
    end

    private
    def post_params
     params.require(:post).permit(:title, :contents)
    end

    def category_params
     params.require(:category).permit(:name)   
    end
end


