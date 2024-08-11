# frozen_string_literal: true

class Icon::Base::Component < ViewComponent::Base
  attr_reader :options

  def initialize(options = {})
    @options = options
  end
end
