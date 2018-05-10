class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_can_edit?, :current_user_can_subscribe?, :current_user_subscribed?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
        :account_update,
        keys: [:password, :password_confirmation, :current_password]
    )
  end

  def current_user_can_edit?(model)
    user_signed_in? && (
      model.user == current_user ||
      (model.try(:event).present? && model.event.user == current_user)
    )
  end

  def current_user_can_subscribe?(model)
    !user_signed_in? || (
      current_user != model.subscribers.find_by(id: current_user.id)) && (
      model.user != current_user)
  end

  def current_user_subscribed?
    current_user == Subscription.find_by(user_name: current_user.id).user
  end
end
