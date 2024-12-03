class CryptosController < ApplicationController
  def index

  end


  def show
    @crypto = Crypto.find(params[:id])
    @posts = @crypto.posts.order(created_at: :desc)
    @post = Post.new
    @post.crypto = @crypto
  end

    
end
