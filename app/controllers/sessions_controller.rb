class SessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:create]
  skip_before_action :verify_authenticity_token
  def create
    user = User.where(:email => params[:email]).first
    if user == nil || user.auth(params[:password]) == false
      render :text => "unauthorized", :status => 401
    else
      session = Session.create(:user_id => user.id)
      session.setKey()
      render :json => { :id => session.id, :session_key => session.session_key }
    end
  end

  def logout
    if cookies["_Rock_session_key"].present?
      cookies["_Rock_session_key"] = nil
    end
    @currentSession.destroy
    if session[:user_id].present?
      session[:user_id] = nil
    end
    render :text => "OK"
  end

  def test
    render :text => "OK"
  end
end
