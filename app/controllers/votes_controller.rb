class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @crypto = Crypto.find(params[:crypto_id])
    @vote = current_user.votes.find_or_initialize_by(crypto: @crypto)

    if @vote.persisted?
      redirect_to crypto_path(@crypto), alert: "You have already voted for this cryptocurrency."
      return
    end

    @vote.is_bullished = params[:is_bullished] == "true"
    if @vote.save
      save_vote_history(@vote)
      redirect_to crypto_path(@crypto), notice: "Your vote has been successfully recorded."
    else
      redirect_to crypto_path(@crypto), alert: "An error occurred while saving your vote."
    end
  end

  private

  def save_vote_history(vote)
    VotesHistory.create(
      crypto_id: vote.crypto_id,
      user_id: vote.user_id,
      is_bullished: vote.is_bullished,
      voted_at: vote.created_at
    )
  end

end
