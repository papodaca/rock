class ApplicationController < ActionController::Base
  protect_from_forgery
  include PaginateHelper

  before_filter :require_login

  private

  def require_login
    if request.headers['session_key'].present?
      s = Session.where(:session_key => request.headers['session_key']).first
      session[:user_id] = s.user_id
    elsif params[:session_key].present?
      s = Session.where(:session_key => params[:session_key]).first
      session[:user_id] = s.user_id
    elsif cookies[:session_key].present?
      s = Session.where(:session_key => cookies[:session_key]).first
      session[:user_id] = s.user_id
    end
    if session[:user_id].present?
      @user = User.find(session[:user_id])
    else
      render :text => "unauthorized", :status => 401
    end
  end
end
