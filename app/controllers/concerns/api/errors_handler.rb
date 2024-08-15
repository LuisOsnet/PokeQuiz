# frozen_string_literal: true

module Api
  module ErrorsHandler
    extend ActiveSupport::Concern

    def error(http_status_code, resource = nil, message = nil)
      opts = {status: http_status_code}
      opts[:message] ||= message || I18n.t("activerecord.errors.response.#{http_status_code}")
      opts[:errors] ||= resource

      render status: http_status_code, json: {
        error: {
          code: Rack::Utils.status_code(http_status_code),
          status: http_status_code,
          resource: controller_name,
          message: opts[:message],
          details: opts[:errors] || {}
        }
      }
    end
  end
end
