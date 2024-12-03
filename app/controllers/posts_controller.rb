class PostsController < ApplicationController

  def create
    @crypto = Crypto.find(params[:crypto_id])
    @post = Post.new(post_params)
    @post.crypto = @crypto
    @post.user = current_user

    if @post.save
      flash[:notice] = "Votre post a été créé avec succès !"
      redirect_to crypto_path(@crypto)
    else
      flash.now[:alert] = "Erreur lors de la création du post."
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to crypto_path(@crypto)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end



