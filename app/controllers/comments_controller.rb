class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy ]

  def create
    @post = Post.find(params[:post_id])
    @crypto = @post.crypto
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      redirect_to crypto_path(@crypto), notice: "Your comment has been successfully added!"
    else
      @comments = @post.comments.order(created_at :desc)
      @posts = @crypto.posts.order(created_at: :desc)
      flash.now[:alert] = "An error occurred while creating your comment. Please try again."
      render "cryptos/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @crypto = @comment.post.crypto
    @comment.destroy
    redirect_to crypto_path(@crypto), notice: "Your comment has been successfully deleted"
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
