class GamesController < ApplicationController
  before_action :set_game, only: %i[show]

  def index
  end

  def show
    points = @game.quizzes.sum(:points)
    @game.score = points
    @game.finished = true
    @game.save!
  end

  def create
    @game = current_user.games.new

    if @game.save
      redirect_to game_quizzes_path(@game, locale: I18n.locale), notice: I18n.t('games.create.success')
    else
      render :new, alert: 'There was an error creating the game.'
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
