class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery
  check_authorization unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :check_user_banned_status

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      session[:next] = request.fullpath
      redirect_to login_url, alert: 'You have to log in to continue.'
    else
      respond_to do |format|
        format.json { render nothing: true, status: :not_found }
        format.html { redirect_to main_app.root_url, alert: exception.message }
        format.js { render nothing: true, status: :not_found }
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[role first_name last_name institution])
  end

  def check_user_banned_status
    return unless current_user&.banned?

    sign_out current_user
    redirect_to root_path, alert: 'Your account has been banned.'
  end
end
