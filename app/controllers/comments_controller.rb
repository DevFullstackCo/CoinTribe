class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @crypto = @post.crypto
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      redirect_to crypto_path(@crypto), notice: "Votre commentaire a été ajouté avec succès !"
    else
      @comments = @post.comments.order(created_at :desc)
      @posts = @crypto.posts.order(created_at: :desc)
      flash.now[:alert] = "Erreur lors de la création de votre commentaire."
      render "cryptos/show"
    end
  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end

