module Refrigeration
  module Branches
    class Fridge < Api
      UNPROCESSABLE = 'No fue posible extraer los datos de la nevera'.freeze
      private_constant :UNPROCESSABLE

      def initialize(fridge_id)
        @fridge_id = fridge_id
      end

      def by_fridge
        response = self.class.get("/branches/fridge/#{@fridge_id}", setting_request)
        raise unless valid_response?(response)

        response
      rescue StandardError => e
        logger_exceptions(UNPROCESSABLE.to_s, e)
        { message: UNPROCESSABLE.to_s, status: :not_found }
      end
    end
  end
end
