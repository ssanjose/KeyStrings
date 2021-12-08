class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  before_action :authenticate_user!
  before_action :init_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_admin_user, :visit_count, :cart

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def current_admin_user
    @current_admin_user ||= AdminUser.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_admin_user!; end

  # -------------------[ Sessions ]-----------------------
  def init_session
    session[:shopping_cart] ||= []
  end

  def cart
    Item.find(session[:shopping_cart])
  end

  def visit_count
    session[:visit_count]
  end
  # -------------------[ Sessions ]-----------------------

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :phone, :province_id, :password)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :phone, :province_id, :password, :current_password)
    end
  end
end
