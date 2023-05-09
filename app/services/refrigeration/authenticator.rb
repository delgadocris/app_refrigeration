module Refrigeration
  module Authenticator
    def auth
      { token: Rails.configuration.refrigeration[:auth_token] }
    end
  end
end
