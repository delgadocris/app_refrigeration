class Api::V1::BranchesController < Api::ApplicationController
  before_action :authenticate_user!

  # GET "/api/v1/branches/by_fridge?fridge=#{fridge}"
  def by_fridge
    return json_response('Debe agregar una nevera correcta', :bad_request) unless params[:fridge].present?

    response = Refrigeration::Branches::Fetch.new(params[:fridge]).by_fridge
    return json_response(response[:message], response[:status]) if response[:status] == :not_found

    @message = JSON.parse(response.body)['message']
    @branch = JSON.parse(response.body)['branch'].with_indifferent_access

    render :by_fridge
  end
end
