class ApplicationController < ActionController::Base
  protect_from_forgery
  include PaginateHelper

  before_filter :require_login

  private

  def require_login
    @currentSession = nil
    if request.headers['Session-key'].present? and !@currentSession.present?
      @currentSession = Session.where(:session_key => request.headers['Session-key']).first
    elsif params[:session_key].present? and !@currentSession.present?
      @currentSession = Session.where(:session_key => params[:session_key]).first
    elsif cookies["_Rock_session_key"].present? and !@currentSession.present?
      @currentSession = Session.where(:session_key => cookies["_Rock_session_key"]).first
    end
    if @currentSession.present?
      session[:user_id] = @currentSession.user_id
    else
      render :text => "unauthorized", :status => 401
    end
  end
end
