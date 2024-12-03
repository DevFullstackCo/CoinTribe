class PostsController < ApplicationController

  def create
    @crypto = Crypto.find(params[:crypto_id])
    @post = Post.new(post_params)
    @post.crypto = @crypto
    @post.user = current_user

    if @post.save
      redirect_to crypto_path(@crypto), notice: "Votre post a été ajouté avec succès !"
    else
      @posts = @crypto.posts.order(created_at: :desc) 
      flash.now[:alert] = "Erreur lors de la création du post."
      render "cryptos/show"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @crypto = @post.crypto
    @post.destroy
    redirect_to crypto_path(@crypto), notice: "Le post a été supprimé avec succès."
  end


  private

  def post_params
    params.require(:post).permit(:content)
  end

end



