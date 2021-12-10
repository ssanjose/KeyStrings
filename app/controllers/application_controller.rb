class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  before_action :authenticate_user!
  before_action :init_session, :picks
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_admin_user, :visit_count, :cart, :access_denied, :current_user,
                :authenticate_admin_user, :add_qty, :minus_qty

  def access_denied(exception)
    logger.debug("access_denied")
    redirect_to root_path, alert: exception.message
  end

  def current_admin_user
    logger.debug("current_admin_user!")
    logger.debug("#{current_user}!")
    if user_session
      @current_admin_user = AdminUser.find_by(email: current_user.email)
      logger.debug(@current_admin_user) if @current_admin_user
    end

    @current_admin_user
  end

  def authenticate_admin_user!
    logger.debug("authenticate_admin_user")
    logger.debug(current_user.email.to_s + "dasdasd")
    return false unless current_user.admin?

    true
  end

  # -------------------[ Sessions ]-----------------------
  def init_session
    session[:picked_categories] ||= []
  end

  def cart
    # session[:shopping_cart] = []
    session[:shopping_cart] ||= []
    if session[:shopping_cart].count.positive?
      Item.find(session[:shopping_cart].map { |item| item["id"] })
    else
      []
    end
  end

  def visit_count
    session[:visit_count]
  end

  def picks
    @picks = Category.find(session[:picked_categories])
  end

  def add_qty(id)
    session[:shopping_cart].each do |item|
      item["qty"] += 1 if item["id"] == id
    end
  end

  def minus_qty(id)
    session[:shopping_cart].each do |item|
      item["qty"] -= 1 if item["id"] == id
    end
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
