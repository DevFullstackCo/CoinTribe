class CryptosController < ApplicationController
  def index
    @new_cryptos = Crypto.order(created_at: :desc).limit(5)

    if params[:search].present?
      @cryptos = Crypto.search_by_name_or_symbol(params[:search])
    else
      @cryptos = Crypto.limit(5)
    end

    respond_to do |format|
      format.html 
      format.json { render json: @cryptos.pluck(:id, :name, :symbol, :price, :volume_24h) }
    end
  end

  def show
    @crypto = Crypto.find(params[:id])
    @posts = @crypto.posts.order(created_at: :desc)
    @post = Post.new
    @post.crypto = @crypto
  end

    
end
