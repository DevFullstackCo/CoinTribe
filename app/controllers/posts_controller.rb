class PostsController < ApplicationController

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

  def load_comments
    @post = Post.find(params[:post_id])
    @comments = @post.comments.order(created_at: :desc).(params[:page]).per(2)

    respond_to do |format|
      format.turbo_stream
      format.html { render partial: 'posts/comments', locals: { comments: @comments } }
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



