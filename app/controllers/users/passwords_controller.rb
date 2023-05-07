# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
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

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    root_path
  end
end
