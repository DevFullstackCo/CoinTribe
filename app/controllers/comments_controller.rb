class CommentsController < ApplicationController

  def create
    @crypto = Crypto.find(params[:crypto_id])
    @post = @crypto.post
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @commeht.user = current_user

    if @comment.save
      redirect_to crypto_path(@crypto)
    else
      
    end


  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end

