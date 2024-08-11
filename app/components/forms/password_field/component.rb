# frozen_string_literal: true

class Forms::PasswordField::Component < ViewComponent::Base
  attr_reader :form, :object_name, :label, :options

  def initialize(form:, object_name:, label: nil, **options)
    @form = form
    @object_name = object_name
    @label = label
    @options = options
  end

  def has_errors?
    @form.object.respond_to?(:errors) && @form.object.errors.has_key?(@object_name)
  end
end
