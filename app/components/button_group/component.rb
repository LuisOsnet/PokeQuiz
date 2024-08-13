# frozen_string_literal: true

class ButtonGroup::Component < ViewComponent::Base
  attr_reader :form, :game_id, :options

  def initialize(form:, game_id:, **options)
    @form = form
    @game_id = game_id
    @options = options
  end

  def show_modal?
    game = Game.find(game_id)
    count = game.quizzes.count
    count == 3 || (count > 3 && (count - 3) % 5 == 0)
  end
end