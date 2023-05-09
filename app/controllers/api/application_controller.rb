module Api
  class ApplicationController < ActionController::API
    include ActionController::MimeResponds
    before_action :set_locale

    def set_locale
      I18n.locale = 'es'
    end

    def json_response(messages, status)
      render json: {
        messages: messages
      }, status: status
    end
  end
end
