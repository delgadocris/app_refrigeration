# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :prevent_sign_up, only: %i[create new]
  skip_before_action :require_no_authentication, only: %i[create new]

  private

  def prevent_sign_up
    unless user_signed_in?
      respond_to do |format|
        format.html { redirect_to branches_url, alert: t('devise.failure.unauthenticated') }
        format.json { head :no_content }
      end
    end
  end

  protected

  def sign_up(resource_name, resource)
    root_path
  end
end
