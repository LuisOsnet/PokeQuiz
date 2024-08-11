# frozen_string_literal: true

class Forms::Submit::Component < ViewComponent::Base
  attr_reader :form, :label, :options

  def initialize(form:, label:, **options)
    @form = form
    @label = label
    @options = options
  end
end
