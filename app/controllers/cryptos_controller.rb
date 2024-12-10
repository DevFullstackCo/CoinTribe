class CryptosController < ApplicationController
  
  def index
    @user = current_user
    @new_cryptos = Crypto.order(created_at: :desc).limit(5)
    if params[:search].present?
      @cryptos = Crypto.search_by_name_or_symbol(params[:search])
    else
      @cryptos = Crypto.limit(5)
    end

    respond_to do |format|
      format.html
      format.json { render json: @cryptos.pluck(:id, :name, :symbol, :price, :variation_24h, :logo_url) }
    end
  end

def show
  @user = current_user
  @crypto = Crypto.find(params[:id])
  @posts = @crypto.posts.includes(:comments).order(created_at: :desc)
  @post = Post.new
  @comment = Comment.new
  @favorite = Favorite.find_by(user: current_user, crypto: @crypto) || Favorite.new(crypto: @crypto, user: current_user)
  @voteshistory_by_day = VotesHistory.where(crypto_id: @crypto.id)
                                      .group("DATE(created_at)", "is_bullished")
                                     .count


end
end
