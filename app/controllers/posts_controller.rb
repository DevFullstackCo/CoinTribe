class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @crypto = Crypto.find(params[:crypto_id])
    @post = Post.new(post_params)
    @post.crypto = @crypto
    @post.user = current_user

    if @post.save
      redirect_to crypto_path(@crypto), notice: "Your post has been successfully added!"
    else
      @posts = @crypto.posts.order(created_at: :desc) 
      flash.now[:alert] = "An error occurred while creating your post. Please try again."
      render "cryptos/show"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @crypto = @post.crypto
    @post.destroy
    redirect_to crypto_path(@crypto), notice: "Your post has been successfully deleted"
  end


  private

  def post_params
    params.require(:post).permit(:content)
  end

end



