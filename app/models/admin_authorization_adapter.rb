class AdminAuthorizationAdapter < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    return false if user.nil?

    true
  end
end
