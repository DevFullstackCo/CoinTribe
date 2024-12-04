class CommentsController < ApplicationController

  def create
    @crypto = Crypto.find(params[:crypto_id])
    @post = @crypto.post
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      redirect_to crypto_path(@crypto), notice: "Votre commentaire a été ajouté avec succès !"
    else
      @comments = @post.comments.order(created_at :desc)
      flash.now[:alert] = "Erreur lors de la création de votre commentaire."
      render "crypto/show"
    end
  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end

